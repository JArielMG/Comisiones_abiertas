function ocultaTitularesCR(){
	document.getElementById("lstTitulares").style.display = 'none';
	document.getElementById("lstTodos").style.display = 'block';
	document.getElementById("lnkTit").style.color="#FFFFFF";
	document.getElementById("lnkTod").style.color="#9302CF";
}

function muestraTitularesCR(){
	document.getElementById("lstTitulares").style.display = 'block';
	document.getElementById("lstTodos").style.display = 'none';	
	document.getElementById("lnkTit").style.color="#9302CF";
	document.getElementById("lnkTod").style.color="#FFFFFF";
}


function ocultaTitularesPE(){
	document.getElementById("lstTitularesServ").style.display = 'none';
	document.getElementById("lstTodosServ").style.display = 'block';
	document.getElementById("lnkTitTvt").style.color="#FFFFFF";
	document.getElementById("lnkTodTvt").style.color="#9302CF";
}

function muestraTitularesPE(){
	document.getElementById("lstTitularesServ").style.display = 'block';
	document.getElementById("lstTodosServ").style.display = 'none';	
	document.getElementById("lnkTitTvt").style.color="#9302CF";
	document.getElementById("lnkTodTvt").style.color="#FFFFFF";
}


function ocultaTitularesCRea(){
	document.getElementById("lstTitularesComis").style.display = 'none';
	document.getElementById("lstTodosComis").style.display = 'block';
	document.getElementById("lnkTitSvc").style.color="#FFFFFF";
	document.getElementById("lnkTodSvc").style.color="#9302CF";
}

function muestraTitularesCRea(){
	document.getElementById("lstTitularesComis").style.display = 'block';
	document.getElementById("lstTodosComis").style.display = 'none';
	document.getElementById("lnkTitSvc").style.color="#9302CF";
	document.getElementById("lnkTodSvc").style.color="#FFFFFF";
}