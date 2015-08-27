.. _week-service-test:

==================
Week service test 
==================



.. note::

    .. include:: ../python-example-header.txt

    
filename => ``ex28.py``

::

	
	from pmis.cons.workreport import WeekReportService
	from java.util import Calendar
	from pmis.cons.workreport import WeekReportService
	
	
	cal = GregorianCalendar.getInstance();
	cal.setMinimalDaysInFirstWeek(4)
	cal.setFirstDayOfWeek(2)
	
	cal.set(2008,9, 28)
	
	week = cal.get( Calendar.WEEK_OF_MONTH )
	print 'week: ' + str(week) + ' month: ' + str(cal.get(Calendar.MONTH) + 1)
	#print cal.get( Calendar.WEEK_OF_YEAR )
	#print WeekReportService.getWeekEndDate('2012011')
	
	print 'last of the month: ' + str(cal.getActualMaximum(Calendar.DAY_OF_MONTH))
	
	if week == 0:
	    dayofweek = cal.get(Calendar.DAY_OF_WEEK)
	    print 'dayofweek: ' + str(dayofweek)
	    if dayofweek == 6 or dayofweek == 7 or dayofweek == 1:
	    	cal.add(Calendar.MONTH, -1)
	        cal.set(Calendar.DAY_OF_MONTH, cal.getActualMaximum(Calendar.DAY_OF_MONTH))
	        week = cal.get( Calendar.WEEK_OF_MONTH )
	elif week == 5:
	    cal.set(Calendar.DAY_OF_MONTH,cal.getActualMaximum(Calendar.DAY_OF_MONTH))
	    dayofweek = cal.get(Calendar.DAY_OF_WEEK)
	    print 'dayofweek: ' + str(dayofweek)
	    if dayofweek > 1 and dayofweek < 5:
	        # if thrusday, friday, saturday, sunday
	        cal.add(Calendar.MONTH, 1)
	        cal.set(Calendar.DAY_OF_MONTH, 1)
	        week = cal.get(Calendar.WEEK_OF_MONTH)
	        
	print 'week: ' + str(week) + ' month: ' + str(cal.get(Calendar.MONTH) + 1)