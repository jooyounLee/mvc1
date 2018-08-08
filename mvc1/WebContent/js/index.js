$(function(){
	
	var PATH = window.location.protocol + "//" + window.location.host;
	
	var goWrite = () => {
		$(".btn-goWrite").on('click', () => {
			location.href = PATH + "/mvc1/form.jsp?idx=&isNew=true";
		});
	}
	
	goWrite();

});