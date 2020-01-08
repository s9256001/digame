#!/bin/bash
source pm_operation
source menu

commands=(1)
descriptions=(\
	'restart officeApi'\
	)
funcs=(\
	'officeApi_restart'\
	)

menu_loop "pm operation" commands descriptions funcs
