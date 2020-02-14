function initMainMenu(mmenuId) {
	document.getElementById(mmenuId).click();
	document.getElementById('test_BTN').click();
}

function setMainMenuButtonSelection(elmnt) {
	var elmnt_CLASS = elmnt.className;
	paintActiveClassId(elmnt);

	var elmnt_ID = elmnt.id;
	var div_ID = elmnt_ID.replace('_BTN', '_DIV');
	elmnt_DIV = document.getElementById(div_ID);

	if (div_ID == "postman_DIV") {
		if (getActiveApp() == "")
		document.getElementById('test_BTN').click();
	}

	displayActiveClassId(elmnt_DIV);
}
