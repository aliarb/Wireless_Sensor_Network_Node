/*
 * Copyright (c) 2015-2016, Texas Instruments Incorporated
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * *  Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * *  Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * *  Neither the name of Texas Instruments Incorporated nor the names of
 *    its contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

/***** Includes *****/

#include <xdc/std.h>
#include <xdc/runtime/System.h>

#include <ti/sysbios/BIOS.h>
#include <ti/sysbios/knl/Task.h>
#include <ti/sysbios/knl/Semaphore.h>
#include <ti/sysbios/knl/Event.h>
#include <ti/sysbios/knl/Clock.h>
#include <ti/drivers/i2c/I2CCC26XX.h>

#include <ti/drivers/PIN.h>

/* Board Header files */
#include "Board.h"

/* Sensors to be included */
#include "sensors/SensorUtil.h"
#include "sensors/SensorI2C.h"
#include "sensors/SensorMpu9250.h"
#include "sensors/SensorOpt3001.h"
#include "sensors/SensorTmp007.h"

#include "SceAdc.h"
#include "NodeTask.h"
#include "NodeRadioTask.h"
#include "PersonalizationTask.h"



/* Parking Variables */
// Configurable in later versions //
uint32_t parkingAddress=30007;
uint16_t sleepDuration_Second=15;

/***** Defines *****/
#define NODE_TASK_STACK_SIZE 1024
#define NODE_TASK_PRIORITY   3

#define NODE_EVENT_ALL                  0xFFFFFFFF
#define NODE_EVENT_NEW_ADC_VALUE    (uint32_t)(1 << 0)

/* A change mask of 0xFF0 means that changes in the lower 4 bits does not trigger a wakeup. */
#define NODE_ADCTASK_CHANGE_MASK                    0xFFF

/* Minimum slow Report interval is 50s (in units of samplingTime)*/
#define NODE_ADCTASK_REPORTINTERVAL_SLOW                5
/* Minimum fast Report interval is 1s (in units of samplingTime) for 30s*/
#define NODE_ADCTASK_REPORTINTERVAL_FAST                1
#define NODE_ADCTASK_REPORTINTERVAL_FAST_DURIATION_MS   1000
//////////////////////////////////////////
//#define delay_ms(i) (CPUdelay(8000 * (i)))
//#define sleep_ms(i) Task_sleep(((i) * 1000) / Clock_tickPeriod)

/***** Variable declarations *****/
static Task_Params nodeTaskParams;
Task_Struct nodeTask;    /* not static so you can see in ROV */
static uint8_t nodeTaskStack[NODE_TASK_STACK_SIZE];
Event_Struct nodeEvent;  /* not static so you can see in ROV */
static Event_Handle nodeEventHandle;
static uint16_t latestAdcValue;

/****** Sensor Variables *****/ //.C and .H files should be added for MgneticSensor
//#define SENSOR_DATA_LEN              18
#define DEFUALT_SENSOR_SLEEP_TIME            120
static uint16_t sensorData[3];
static uint16_t sensorData_Ini[3];
static uint16_t compared;
#define DEFUALT_THERESHHOLD         250
static uint16_t thereshhold=DEFUALT_THERESHHOLD;
static uint8_t CarIsParked;
static uint8_t CarIsParked_Old;
static uint8_t doubleCheck;
//////////////////////////////////////
//static uint16_t DailyreportTime = 21600;


/* Clock for the fast report timeout */
Clock_Struct fastReportTimeoutClock;     /* not static so you can see in ROV */
static Clock_Handle fastReportTimeoutClockHandle;

/* Pin driver handle */
//static PIN_Handle buttonPinHandle;
static PIN_Handle ledPinHandle;
//static PIN_State buttonPinState;
static PIN_State ledPinState;

PIN_Config pinTable[] = {
    NODE_ACTIVITY_LED | PIN_GPIO_OUTPUT_EN | PIN_GPIO_LOW | PIN_PUSHPULL | PIN_DRVSTR_MAX,
    PARKING_STATE_LED | PIN_GPIO_OUTPUT_EN | PIN_GPIO_LOW | PIN_PUSHPULL | PIN_DRVSTR_MAX,
    Board_MIC_POWER | PIN_GPIO_OUTPUT_EN | PIN_GPIO_LOW | PIN_PUSHPULL | PIN_DRVSTR_MAX,
    Board_AUDIO_CLK | PIN_GPIO_OUTPUT_EN | PIN_GPIO_LOW | PIN_PUSHPULL | PIN_DRVSTR_MAX,
    Board_AUDIOFS_TDO | PIN_GPIO_OUTPUT_EN | PIN_GPIO_LOW | PIN_PUSHPULL | PIN_DRVSTR_MAX,
    Board_AUDIODO | PIN_GPIO_OUTPUT_EN | PIN_GPIO_LOW | PIN_PUSHPULL | PIN_DRVSTR_MAX,
    Board_BUZZER | PIN_GPIO_OUTPUT_EN | PIN_GPIO_LOW | PIN_PUSHPULL | PIN_DRVSTR_MAX,
    PIN_TERMINATE
};

/*
 * Application button pin configuration table:
 *   - Buttons interrupts are configured to trigger on falling edge.
 */
PIN_Config buttonPinTable[] = {
    Board_BUTTON0  | PIN_INPUT_EN | PIN_PULLUP | PIN_IRQ_NEGEDGE,
    PIN_TERMINATE
};

/***** Prototypes *****/
static void nodeTaskFunction(UArg arg0, UArg arg1);
void fastReportTimeoutCallback(UArg arg0);
void adcCallback(uint16_t adcValue);
void buttonCallback(PIN_Handle handle, PIN_Id pinId);


/***** Function definitions *****/
void NodeTask_init(void)
{

    /* Create event used internally for state changes */
    Event_Params eventParam;
    Event_Params_init(&eventParam);
    Event_construct(&nodeEvent, &eventParam);
    nodeEventHandle = Event_handle(&nodeEvent);

    /* Create clock object which is used for fast report timeout */
    //Clock_Params clkParams;
    //clkParams.period = 0;
    //clkParams.startFlag = FALSE;
    //Clock_construct(&fastReportTimeoutClock, fastReportTimeoutCallback, 1, &clkParams);
    //fastReportTimeoutClockHandle = Clock_handle(&fastReportTimeoutClock);

    /* Create the node task */
    Task_Params_init(&nodeTaskParams);
    nodeTaskParams.stackSize = NODE_TASK_STACK_SIZE;
    nodeTaskParams.priority = NODE_TASK_PRIORITY;
    nodeTaskParams.stack = &nodeTaskStack;
    Task_construct(&nodeTask, nodeTaskFunction, &nodeTaskParams, NULL);
}

void DisableOtherSensors()
{
    // Disable other I2C sensors
    PIN_setOutputValue(ledPinHandle, PARKING_STATE_LED,Board_LED_ON);
    SensorOpt3001_init();
    SensorTmp007_init();
    SensorI2C_close();
    DELAY_MS(1000);
    PIN_setOutputValue(ledPinHandle, PARKING_STATE_LED,Board_LED_OFF);
}
void CalibrateParkingSensor()
{
    PIN_setOutputValue(ledPinHandle, PARKING_STATE_LED,Board_LED_ON);
    uint8_t status;
    if (SensorI2C_open(SENSOR_I2C_1))
    {
        // Put unused external sensors and flash into Sleep
        SensorMpu9250_powerOn();
        DELAY_MS(200);
        SensorMpu9250_enable(0x40);
        if(SensorMpu9250_test()){
            //status=SensorMpu9250_accReadRange();
            DELAY_MS(200);
            status=SensorMpu9250_magRead((int16_t*)&sensorData_Ini[0]);
            if (status != MAG_STATUS_OK)
            {
                SensorMpu9250_magReset();
                DELAY_MS(100);
                status=SensorMpu9250_magRead((int16_t*)&sensorData_Ini[0]);
            }
            //SensorMpu9250_accRead((uint16_t*)&sensorData[0]);
            //static int16_t temp_sensorData_Ini[3];
            //status=SensorMpu9250_magRead((int16_t*)&sensorData_Ini[0]);
            //SensorI2C_close();
            SensorMpu9250_powerOff();
            PIN_setOutputValue(ledPinHandle, PARKING_STATE_LED,Board_LED_OFF);
        }
    }
    else
    {
       System_abort("Error initializing sensors\n");
    }
}

static uint16_t comparechange(int16_t *val,int16_t *val2)
{
    return (abs(val2[0]-val[0])+abs(val2[1]-val[1])+abs(val2[2]-val[2]));
}

uint8_t CheckParkingSensor()
{
         // Send MPU value to concentrator
        // Toggle activity LED
        if (SensorI2C_open(SENSOR_I2C_1))
        {
            // Put unused external sensors and flash into Sleep
            SensorMpu9250_powerOn();
            SensorMpu9250_enable(0x40);
            DELAY_MS(7);
            int status=SensorMpu9250_magRead((int16_t*)&sensorData[0]);
            if (status != MAG_STATUS_OK)
            {
                PIN_setOutputValue(ledPinHandle, PARKING_STATE_LED, Board_LED_ON);
                PIN_setOutputValue(ledPinHandle, NODE_ACTIVITY_LED, Board_LED_ON);
                SensorMpu9250_magReset();
                DELAY_MS(100);
                status=SensorMpu9250_magRead((int16_t*)&sensorData[0]);
                PIN_setOutputValue(ledPinHandle, PARKING_STATE_LED, Board_LED_OFF);
                PIN_setOutputValue(ledPinHandle, NODE_ACTIVITY_LED, Board_LED_OFF);
                //cntr++;
            }
            SensorI2C_close();
            SensorMpu9250_powerOff();
            compared = comparechange((int16_t*)&sensorData[0],(int16_t*)&sensorData_Ini[0]);
            CarIsParked=(compared > thereshhold);
            if (CarIsParked)
                 PIN_setOutputValue(ledPinHandle, PARKING_STATE_LED, Board_LED_ON);
            else
                 PIN_setOutputValue(ledPinHandle, NODE_ACTIVITY_LED,Board_LED_ON);
            DELAY_MS(75);
            PIN_setOutputValue(ledPinHandle, PARKING_STATE_LED, Board_LED_OFF);
            PIN_setOutputValue(ledPinHandle, NODE_ACTIVITY_LED,Board_LED_OFF);
            if (CarIsParked != CarIsParked_Old || IsReportTime())
            {
                doubleCheck++;
                if (doubleCheck > 0 || IsReportTime())
                {
                    NodeRadioTask_sendParkingData(compared,CarIsParked,parkingAddress); //We have to add packet type here
                    CarIsParked_Old=CarIsParked;
                    doubleCheck=0;
                }
                return 1;
            }
            else
                return 0;
        }
        else
            return 255;
}

static void nodeTaskFunction(UArg arg0, UArg arg1)
{
///////////////////////////////////////
    /////////////
    // Open LED pins
    ledPinHandle = PIN_open(&ledPinState, pinTable);
    if (!ledPinHandle)
    {
        System_abort("Error initializing board 3.3V domain pins\n");
    }


    //////////////////////////////////////////////////////////////
    PIN_setOutputValue(ledPinHandle, NODE_ACTIVITY_LED,Board_LED_ON);
    SensorMpu9250_powerOff();
    PIN_setOutputValue(ledPinHandle, Board_MIC_POWER,Board_MIC_POWER_OFF);
    PIN_setOutputValue(ledPinHandle, Board_BUZZER,Board_BUZZER_OFF);
    DELAY_MS(500);
    PIN_setOutputValue(ledPinHandle, NODE_ACTIVITY_LED,Board_LED_OFF);


    /////////////////////////////////////////////////////////////
    CalibrateParkingSensor();
    DisableOtherSensors();


    CarIsParked_Old = CarIsParked+1;
    while(1) {

        //uint32_t events = Event_pend(nodeEventHandle, 0, NODE_EVENT_ALL, BIOS_WAIT_FOREVER);
        // If new ADC value, send this data
        //if (1)//events & NODE_EVENT_NEW_ADC_VALUE)
        //{
        // if (GetCurrentTask()!=NodeOperationMode_SleepTime)
        uint8_t temp = getSleepValue();
        if (temp==0)
            temp=70;
        else
            CheckParkingSensor();

        DELAY_MS(temp*1000);
    }
}


void adcCallback(uint16_t adcValue)
{
    /* Save latest value */
    latestAdcValue = adcValue;

    /* Post event */
    Event_post(nodeEventHandle, NODE_EVENT_NEW_ADC_VALUE);
}

/*
 *  ======== buttonCallback ========
 *  Pin interrupt Callback function board buttons configured in the pinTable.
 */
void buttonCallback(PIN_Handle handle, PIN_Id pinId)
{
    /* Debounce logic, only toggle if the button is still pushed (low) */
    CPUdelay(8000*50);


    if (PIN_getInputValue(Board_BUTTON0) == 0)
    {
        //start fast report and timeout
        SceAdc_setReportInterval(NODE_ADCTASK_REPORTINTERVAL_FAST, NODE_ADCTASK_CHANGE_MASK);
        Clock_start(fastReportTimeoutClockHandle);
    }
}

void fastReportTimeoutCallback(UArg arg0)
{
    //stop fast report
    SceAdc_setReportInterval(NODE_ADCTASK_REPORTINTERVAL_SLOW, NODE_ADCTASK_CHANGE_MASK);
}
