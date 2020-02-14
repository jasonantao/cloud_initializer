function callRestApi(urlElmt, restMethod, jsonResponse_Div) {
	var url = document.getElementById(urlElmt).value;
	var method = document.getElementById(restMethod).value.toUpperCase();
	var response = document.getElementById(jsonResponse_Div);
	response.innerHTML = "";

	switch (method) {
		case "GET":
			ajaxGetJson(url, response);
			break;
		case "POST":
			var body = document.getElementById("restRequestBody");
			ajaxPostJson(url, response, body);
			break;
		default:
			response.innetHTML = "UNKNOWN METHOD " + method;
	}
}

function ajaxGetJson(url, response) {
	var status;

//	alert("EXECUTING: GET@" + url)

	$.support.cors = true;
	$.getJSON(url, function (data, status) {
		if (status === "success") {
			if (status === "success") {
				var beautifiedData = JSON.stringify(data, null, 4.);
				console.log("data = " + data);
				console.log("beautifiedData = " + beautifiedData);
				console.log("GetJSON \ajaxGetJson(" + url + ")\n" + url + "\nWORKS status = " + status + "\ndata = \n" + data);
				response.innerHTML = "<pre>" + beautifiedData + "</pre>";
			}
			else {
				console.log("GetJSON ERROR \ajaxGetJson(" + url + ")\n" + url + "\nWORKS status = " + status + "\ndata = \n" + data);
				alert("GetJSON ERROR \ajaxGetJson(" + url + ")\n" + url + "\nWORKS status = " + status + "\ndata = \n" + data);
			}
			console.log(data);
		}
	});
}

function ajaxPostJson(restURL, response, body) {
//		alert("EXECUTING: 2 POST@" + restURL)
	$.ajax({
		url: restURL,
		type: "POST",
		dataType: 'json',
		data: body,
		contentType: "application/json",
		success: function (data, status, jqXHR) {
			var beautifiedData = JSON.stringify(data, null, 4.);
			response.innerHTML = "<pre>" + beautifiedData + "</pre>";
			console.log("data = " + data);
			console.log("beautifiedData = " + beautifiedData);
//			alert("SUCCESS \ajaxGet(" + restURL + ")\n" + restURL + "\nWORKS status = " + status + "\ndata = \n" + data);
		},
		error: function (xhr, ajaxOptions, errorThrown) {
			var dataResponse = "ERROR \ajaxGet(" + restURL + ")\n" + restURL + "\nFAILED status = " + xhr.status;
			response.innerHTML = "<pre>" + dataResponse + "</pre>";
			alert("ERROR ajaxPostJson response\n" + response);
			console.log(errorThrown);
		}
	});
}

// Possible fix later
/*
function ajaxPostJson(url, response, body) {
	var status;

	$.support.cors = true;
	alert("EXECUTING: 1 POST@" + url)

	$.post(url,   // url
		{ myData: 'This is my data.' }, // data to be submit
		function (data, status, jqXHR) {// success callback
			$('p').append('status: ' + status + ', data: ' + data);
		})

	$.post(url, function (data, status) {
		alert("status = " + status);
	});
}
*/