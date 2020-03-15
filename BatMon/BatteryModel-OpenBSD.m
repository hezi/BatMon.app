/*
   Project: batmon

   Copyright (C) 2006-2014 GNUstep Application Project

   Author: Riccardo Mottola 

   Created: 2013-07-23 Riccardo Mottola

   This application is free software; you can redistribute it and/or
   modify it under the terms of the GNU General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.

   This application is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.

   You should have received a copy of the GNU General Public
   License along with this library; if not, write to the Free
   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111 USA.
*/

#if defined(openbsd) || defined(__OpenBSD__)
#include <unistd.h>
#include <fcntl.h>  /* open */
#include <sys/ioctl.h>
#include <machine/apmvar.h>
#define APMDEV "/dev/apm"
#endif


#import "BatteryModel.h"

@implementation BatteryModel (PlatformSpecific)

- (void)initPlatformSpecific
{
}

- (void)updatePlatformSpecific
{
  int apmfd;
  struct apm_power_info apmPwInfo;
  BOOL validBattery;

  apmfd = open(APMDEV, O_RDONLY);
  if (apmfd == -1)
    return;

  if( -1 == ioctl(apmfd, APM_IOC_GETPOWER, &apmPwInfo) )
    return;

  isCharging = NO;
  isCritical = NO;
  validBattery = YES;
  if (APM_BATT_HIGH == apmPwInfo.battery_state)
    batteryState = BMBStateHigh;
  else if (APM_BATT_LOW == apmPwInfo.battery_state)
    {
      batteryState = BMBStateLow;
    }
  else if (APM_BATT_CRITICAL == apmPwInfo.battery_state)
    {
      batteryState = BMBStateCritical;
      isCritical = YES;
    }
  else if (APM_BATT_CHARGING == apmPwInfo.battery_state)
    {
      batteryState = BMBStateCharging;
      isCharging = YES;
    }
  else if (APM_BATTERY_ABSENT == apmPwInfo.battery_state)
    {
      batteryState = BMBStateMissing;
      validBattery = NO;
    }
  else
    {
      batteryState = BMBStateUnknown;;
      validBattery = NO;
    }

  if (APM_AC_ON == apmPwInfo.ac_state)
    isCharging = YES;

  /* we expect time in hours */
  if (validBattery)
    {
      timeRemaining = (float)apmPwInfo.minutes_left / 60;
      chargePercent = (float)(int)apmPwInfo.battery_life;

      /* sanity checks */
      if (isCharging && timeRemaining > 100)
	timeRemaining = 0;
      if (chargePercent > 100)
	chargePercent = 100;
      else if (chargePercent < 0)
	chargePercent = 0;

      if (timeRemaining < 0)
	timeRemaining = 0;
    }
  else
    {
      chargePercent = 0;
      timeRemaining= 0;
    }

  close(apmfd);
}

@end
