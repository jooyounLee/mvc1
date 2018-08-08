

$(() => {
	
	var PATH = window.location.protocol + "//" + window.location.host;

	var forms = {
			form : $("#form"),
			idx : $("form input[name='idx']"),
			user_nm : $("form input[name='user_nm']"),
			article_pw : $("form input[name='article_pw']"),
			title : $("form input[name='title']"),
			content : $("form textarea[name='content']"),
			isNew : $("form input[name='isNew']"),
			isRead : $("form input[name='isRead']")
	},
	
	save = () => {
		$("input[name='btn-submit']").on('click', () => {
			
			var url = (forms.isNew.val() === "true") ? PATH + "/mvc1/writeAction.jsp" : PATH + "/mvc1/updateAction.jsp"
			
			if (forms.user_nm.val().trim().length < 1) {
				alert("이름을 입력해주세요.");
				forms.user_nm.focus();
				return;
			} else if (forms.article_pw.val().trim().length < 1) {
				alert("비밀번호를 입력해주세요.");
				forms.article_pw.focus();
				return;
			} else if (forms.title.val().trim().length < 1){
				alert("제목을 입력해주세요.");
				forms.title.focus();
				return;
			} else if (forms.content.val().trim().length < 1){
				alert("내용을 입력해주세요.");
				forms.content.focus();
				return;
			}
			
			forms.form.attr("action", url).submit();
		});
	},
	
	modeRead = () => {	// 읽기폼 : input, textarea -> readonly / 비밀번호 input -> hide
		if(forms.isRead.val() === "true") {
			$("#form input").attr("readonly", true);
			$("#form textarea").attr("readonly", true);
			forms.article_pw.parent().hide();
			forms.article_pw.parent().prev().hide();
		}
	},
	
	modeWrite = () => {	//수정, 쓰기 폼 : 버튼 확인, 취소
		if(forms.isRead.val() !== "true") {
			
			var addBtn = '<input type="button" value="확인" name="btn-submit">';
			
			$("#btn-box a").hide();
			$("#btn-box input[name=btn-cancel]").val("취소");
			$("#btn-box input[name=btn-delete]").hide();
			$("#btn-box").append(addBtn);
		}
	},

	goBack = () => {
		$("input[name=btn-cancel]").on('click', () => {
			location.href= PATH + "/mvc1/index.jsp";
		});
	}
	
	modeRead();
	modeWrite();
	save();
	goBack();
});
