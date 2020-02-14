//////////////////////////// START NEW STUFF ///////////////////////////////////

// Set ~ store values in Hash map
// Valid ~ use existing value in hash map or use default and store in Map (Like CASH)
// Active ~ apply properties to a particular element id or class

class ciPostmanAppSettings {
	constructor(app) {
		this.activeApp = app;
		this.idMaps = new Map([]);    // Map of Id maps
		this.classMaps = new Map([]);    // Map of Id maps
	}
	// cookieMap = new Map([ // Map for Cookie store and retreival (Not Yet Implemented)
	// 	["classMaps", classMaps],
	// 	["idMaps", idMaps]
	// ]);
}

// Initialize a constructor from a class
var postmanAppSettings = setNewPostmanApp("test");

function setNewPostmanApp(app) {
	newPostmanAppSettings = new ciPostmanAppSettings("");
	//	alert("postmanAppSettings" = postmanAppSettings);
	//	console.log("postmanAppSettings" = newPostmanAppSettings);
	//	alert("ZZZZ");
	return newPostmanAppSettings;
}

function isValidType(obj) {
	if (typeof (obj) == 'undefined' || obj == null) {
		return false;
	}
	return true;
}

// GENERAL MAP FUNCTIONS

function getCookieMap() {
	return postmanAppSettings.cookieMap;
}
function getClassMaps() {
	return postmanAppSettings.classMaps;
}
function getIdMaps() {
	return postmanAppSettings.idMaps;
}

function getMapValue(map, key) {
	if (!isValidType(key))
		return null;
	return map.get(key);
}

function setValidMap(map, mapKey) {
	var newMap;
	if (isValidType(mapKey)) {
		newMap = new Map([]);
		map.set(mapKey, newMap);
	}
	return newMap;
}

function getValidMap(map, mapKey) {
	var validMap = getMapValue(map, mapKey);
	if (!isValidType(validMap)) {
		validMap = setValidMap(map, mapKey);
	}
	return validMap;
}

function getMapMapProperty(map, mapKey, propertyKey) {
	var property;
	var validMapValue = getMapValue(map, mapKey);
	if (isValidType(validMapValue))
		property = validMapValue.get(propertyKey);
	return property;
}

function setMapMapPropertyValue(map, mapKey, propertyKey, propertyValue) {
	var validMap = getValidMap(map, mapKey);
	if (isValidType(validMap)) {
		if (isValidType(propertyValue) && isValidType(propertyKey)) {
			validMap.set(propertyKey, propertyValue);
		}
	}
	propertyValue = validMap.get(propertyKey);
	return propertyValue;
}

function getValidMapMapProperty(map, mapKey, propertyKey, defaultPropertyValue) {
	var validMapValue = getValidMap(map, mapKey);
	var property = validMapValue.get(propertyKey);
	if (!isValidType(property)) {
		property = defaultPropertyValue;
		validMapValue.set(propertyKey, property);
	}
	return property;
}

// PROCESS ACTIVE APP
function getActiveApp() {
	return postmanAppSettings.activeApp;
}

function setActiveApp(activeApp) {
	return postmanAppSettings.activeApp = activeApp;
}

// PROCESS CLASS MAPS
function getClassMap(mapKey) {
	return getMapValue(postmanAppSettings.classMaps, mapKey);
}

function set(mapKey) {
	return setValidMap(postmanAppSettings.classMaps, mapKey);
}

function getValidClassMap(mapKey) {
	return getValidMap(postmanAppSettings.classMaps, mapKey);
}

function getClassMapProperty(mapKey, propertyKey) {
	return getMapMapProperty(postmanAppSettings.classMaps, mapKey, propertyKey);
}

function setClassMapPropertyValue(mapKey, propertyKey, propertyValue) {
	return setMapMapPropertyValue(postmanAppSettings.classMaps, mapKey, propertyKey, propertyValue);
}

function getValidClassMapProperty(mapKey, propertyKey, defaultValue) {
	return getValidMapMapProperty(postmanAppSettings.classMaps, mapKey, propertyKey, defaultValue);
}

// PROCESS ID MAPS

function getIdMap(mapKey) {
	return getMapValue(postmanAppSettings.idMaps, mapKey);
}

function setIdMap(mapKey) {
	return setValidMap(postmanAppSettings.idMaps, mapKey);
}

function getValidIdMap(mapKey) {
	return getValidMap(postmanAppSettings.idMaps, mapKey);
}

function getIdMapProperty(mapKey, propertyKey) {
	return getMapMapProperty(postmanAppSettings.idMaps, mapKey, propertyKey);
}

function setIdMapPropertyValue(mapKey, propertyKey, propertyValue) {
	return setMapMapPropertyValue(postmanAppSettings.idMaps, mapKey, propertyKey, propertyValue);
}

function getValidIdMapProperty(mapKey, propertyKey, defaultValue) {
	return getValidMapMapProperty(postmanAppSettings.idMaps, mapKey, propertyKey, defaultValue);
}

