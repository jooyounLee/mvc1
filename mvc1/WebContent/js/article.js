

$(() => {

	var el = {
			form : $("#form"),
			form_read : $("#form-read"),
			idx : $("input[name='idx']"),
			user_nm : $("input[name='user_nm']"),
			article_pw : $("input[name='article_pw']"),
			re_password : $("input[name='re-password']"),
			title : $("input[name='title']"),
			content : $("textarea[name='content']"),
			isNew : $("input[name='isNew']"),
			modify_btn : $("input[name=btn-modify]"),
			delete_btn : $("input[name=btn-delete]"),
			cancel_btn : $("input[name=btn-cancel]"),
			submit_btn : $("input[name='btn-submit']")
	},
	
	btnEvent = () => {
		// 확인버튼 클릭 : 쓰기, 수정
		el.submit_btn.on('click', save);
		
		// 수정버튼 클릭
		el.modify_btn.on('click', ()=>{
			if (el.re_password.val().trim().length < 1) {
				alert("비밀번호를 입력해주세요.");
				el.re_password.focus();
				return;
			}
			var url = "/mvc1/form.jsp?idx=" + el.idx.val();
			el.form_read.attr("action", url).submit();
		});
		
		// 삭제버튼 클릭
		el.delete_btn.on('click', ()=>{
			if (el.re_password.val().trim().length < 1) {
				alert("비밀번호를 입력해주세요.");
				el.re_password.focus();
				return;
			}
			var url = "/mvc1/deleteAction.jsp?idx=" + el.idx.val();
			el.form_read.attr("action", url).submit();
		});
		
		// 취소버튼 클릭 : 리스트로 이동
		el.cancel_btn.on('click', () => {
			location.href= "/mvc1/index.jsp";
		});
	},
	
	save = () => {
			var url = (el.isNew.val() === "true") ? "/mvc1/writeAction.jsp" : "/mvc1/updateAction.jsp"
			
			if (el.user_nm.val().trim().length < 1) {
				alert("이름을 입력해주세요.");
				el.user_nm.focus();
				return;
			} else if (el.article_pw.val().trim().length < 1) {
				alert("비밀번호를 입력해주세요.");
				el.article_pw.focus();
				return;
			} else if (el.title.val().trim().length < 1){
				alert("제목을 입력해주세요.");
				el.title.focus();
				return;
			} else if (el.content.val().trim().length < 1){
				alert("내용을 입력해주세요.");
				el.content.focus();
				return;
			}
			
			el.form.attr("action", url).submit();
	}
	
	btnEvent();
});
