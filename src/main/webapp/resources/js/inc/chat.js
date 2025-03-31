
// 자바스크립트 WebSocket 객체를 저장할 변수 선언
let ws;

// 채팅 메세지 타입을 구분하기 위한 상수 설정
const TYPE_ENTER = "ENTER"; //입장
const TYPE_LEAVE = "LEAVE"; //퇴장
const TYPE_TALK = "TALK"; //대화메세지

//채팅 메세지 정렬 위치를 구분하기 위한 상수 설정(뷰페이지에서 표시할때 위치 선정)
const ALIGN_CENTER = "center";
const ALIGN_LEFT = "left";
const ALIGN_RIGHT = "right";

//페이지 로딩 완료 시 채팅 시작
$(function(){
	connect();
	// 전송 버튼 클릭 시
	$("#btnSend").on("click", function(){
		sendInputMessage();
	});
	// 엔터키 판별
	$("#chatMessage").on("keypress", function(event){
		if (event.keyCode == 13) {
			sendInputMessage();
		}
	});
	
})

//최초 1회 웹소켓 연결 수행하는 connect() 함수 정의
function connect(){
	//요청 주소 생성(웹소켓 기본 프로토콜은 ws, 보안 프로토콜은 wss)
	let ws_base_url = "ws://localhost:8080/UNIPICK";
	
	//let ws_base_url = "ws://192.168.2.128:8080/UNIPICK";
	ws = new WebSocket(ws_base_url + "/echo");
	
	ws.onopen = onOpen;
	ws.onclose = onClose;
	ws.onmessage = onMessage;
	ws.onerror = onError;
}

//웹소켓 이벤트를 처리할 핸들러 함수 정의
function onOpen(){
	console.log("onOpen()");
	
	//채팅방에 입장 메세지 출력 => appendMessage() 함수 호출하여 메세지 전달
	appendMessage(">> 채팅방에 입장하였습니다. <<", ALIGN_CENTER);
	//채팅방 입장 정보를 다른 사용자에게 전송(-> 서버측으로 입장 정보 전송)
	sendMessage(TYPE_ENTER, "");	
}

function appendMessage(message, align){
	$('#chatMessageArea').append(`<div class="message ${align}"">${message}</div>`)
}

function sendMessage(type, message){
	let param = {type, message};
	ws.send(JSON.stringify(param));
	// -> 웹소켓을 통해 서버로 메세지가 전송되면
	// 핸들러 객체의 handleTextMessage() 메서드가 자동 호출됨
}

function sendInputMessage(){
	//sendMessage(TYPE_TALK, "테스트");
	
	//채팅 메세지 입력창 내용 가져오기
	let message = $('#chatMessage').val();	
	
	if(message == ""){
		return;
	}
	
	sendMessage(TYPE_TALK, message);
	appendMessage(message, ALIGN_RIGHT);
	//메세지 전송 요청 후 입력창 초기화 및 입력창 커서 요청
	$('#chatMessage').val("");
	$('#chatMessage').focus();
}


function onMessage(event){
	console.log("onMessage()");
	
	let data = JSON.parse(event.data);
	if(data.type == TYPE_ENTER || data.type == TYPE_LEAVE){
		//시스템 메세지의 경우 두번째 파라미터로 "center" 값 전달 (가운데 정렬)
		appendMessage(data.message, ALIGN_CENTER);
	} else if(data.type == TYPE_TALK){
		//사용자 메세제의 경우 appendMessage() 함수 두번째 파라미터로 "left" 값 전달
		//-> 자신의 메세지는 전송되지 않으므로 항상 좌측 정렬(다른 사용자의 메세지)
		appendMessage(data.sender_id + " : " + data.message, ALIGN_LEFT);
	}
	
}








//======================


function onClose(){
	console.log("onClose()");
}
function onError(){
	console.log("onError()");
}
