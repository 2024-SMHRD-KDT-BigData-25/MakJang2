<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이상형 월드컵</title>
    <style>
    
    	*{
		    margin: 0;
		    padding: 0;
		}
		    
        body {
            font-family: Arial, sans-serif;
            align-items: center;
            background-color: #f4f4f4;
			
        }
        
        .worldcup-wrap{
        	border: 3px solid black;
        	background-color: black;
        	margin: 100px auto;
        	width: 80%
        }
        
        .worldcup-wrap2{
        	width: 90%;
            background-color: white;
            margin: auto;
            border-left: 3px solid black;
            border-right: 3px solid black;  
        }
        
        .worldcup-title{
        	text-align: center;
        	border-bottom: 3px solid black;
        	background-color: rgba(0, 0, 0, 0.2);
        	height: 50px;
        	font-size:40px;
        	color: white;
        }
        
        .container {
            text-align: center;
            
        }
        
        .round-wrap{
        	background-color: rgba(243, 190, 155, 0.2);     
        }
        
        #round-title {
		    display: block; !important;/* 요소가 보여지도록 설정 */
		    color: orange;
		    font-size: 24px;
		}
		        
        .image-wrap{
        	background-color: white;
        	border-top: 3px solid black;
        }
                
        .image-container {
            display: flex;
            justify-content: center;  
        }
        
        .image-wrapper {
            margin: 0 20px;
        }
        img {
            max-width: 200px;
            height: auto;
            cursor: pointer;
        }
        .image-name {
            margin-top: 5px;
            font-weight: bold;
        }
        .winner {
            display: none;
            flex-direction: column;
            align-items: center;
            margin-top: 20px;
        }
    </style>
</head>
<body>
<jsp:include page="${contextPath }/header/header.jsp" />
<div class="worldcup-wrap">
	<div class="worldcup-wrap2">
		<div class="worldcup-title">
			<div>칵테일 월드컵</div>
		</div>
		<div id="loader">Loading...</div>
		<div class="container" id="content">
		    <div class="round-wrap">
		    	<h1 id="round-title" style="display: block;">Round 1</h1>
		    </div>
		    <div class="image-wrap">
		    	<div class="image-container" id="image-container"></div>
			    <div class="winner" id="winner">
			        <h2>최종 우승자!</h2>
			        <img id="winner-image" src="" alt="Winner">
			        <div id="winner-name" class="image-name"></div>
			    </div>
		    </div> 
		</div>		
	</div>
</div>

<jsp:include page="${contextPath }/footer/footer.jsp" />



<script>
    let currentRound = 1;
    let initialImages = [];
    let currentImages = [];
    let selectedImages = [];
    let shownImages = []; // 이미 출력된 이미지 기록

    // 초기 데이터 로드
    function loadImages() {
        fetch('getImages.jsp')
            .then(response => response.json())
            .then(data => {
                initialImages = data.images;
                currentImages = [...initialImages];
                if (currentImages.length !== 8) {
                    alert('8개의 이미지를 준비해 주세요!');
                    return;
                }
                renderImages();
            });
    }

    function renderImages() {
        document.getElementById('loader').style.display = 'none';
        document.getElementById('content').style.display = 'block';
        document.getElementById('winner').style.display = 'none';

        // 라운드 제목 설정
        let roundTitleText;
        if (currentRound === 1) {
            roundTitleText = "8강";
        } else if (currentRound === 2) {
            roundTitleText = "4강";
        } else if (currentRound === 3) {
            roundTitleText = "결승";
        } else {
            roundTitleText = "최종 우승자";
        }
        
        document.getElementById('round-title').innerText = roundTitleText;
        
        const imageContainer = document.getElementById('image-container');
        imageContainer.innerHTML = '';

        // 현재 라운드에서 두 개의 이미지를 선택
        if (currentImages.length < 2) {
            showWinner(selectedImages[0]);
            return;
        }

        // 두 개의 이미지를 무작위로 선택
        let indices = [];
        while (indices.length < 2) {
            const index = Math.floor(Math.random() * currentImages.length);
            if (!indices.includes(index) && !shownImages.includes(currentImages[index].name)) {
                indices.push(index);
            }
        }

        const image1 = currentImages[indices[0]];
        const image2 = currentImages[indices[1]];

        // 출력된 이미지 이름 기록
        shownImages.push(image1.name);
        shownImages.push(image2.name);

        createImageElement(image1, imageContainer);
        createImageElement(image2, imageContainer);
    }


    // 이미지 요소 생성 함수
    function createImageElement(image, container) {
        const imgWrapper = document.createElement('div');
        imgWrapper.className = 'image-wrapper';
        const imgElement = document.createElement('img');
        imgElement.src = image.src;
        imgElement.alt = image.name;
        imgElement.onclick = () => selectImage(image);
        const nameElement = document.createElement('div');
        nameElement.className = 'image-name';
        nameElement.innerText = image.name;

        imgWrapper.appendChild(imgElement);
        imgWrapper.appendChild(nameElement);
        container.appendChild(imgWrapper);
    }

    // 이미지를 선택했을 때 처리하는 함수
    function selectImage(image) {
        selectedImages.push(image);
        currentImages = currentImages.filter(img => img !== image); // 선택한 이미지를 제거

        // 라운드에 따른 진행 로직
        if (currentRound === 1 && selectedImages.length === 4) {
            currentRound++;
            alert('4강으로 넘어갑니다!');
            currentImages = selectedImages;
            selectedImages = [];
            shownImages = []; // 선택 초기화
            renderImages();
        } else if (currentRound === 2 && selectedImages.length === 2) {
            currentRound++;
            alert('결승으로 넘어갑니다!');
            currentImages = selectedImages;
            selectedImages = [];
            shownImages = []; // 선택 초기화
            renderImages();
        } else if (currentRound === 3 && selectedImages.length === 1) {
            showWinner(selectedImages[0]);
        } else if (currentImages.length < 2) {
            showWinner(selectedImages[0]);
        } else {
            renderImages();
        }
    }

    // 최종 우승자를 표시하는 함수
    function showWinner(winner) {
        document.getElementById('loader').style.display = 'none';
        document.getElementById('content').style.display = 'block';
        document.getElementById('winner').style.display = 'flex';
        document.getElementById('round-title').style.display = 'none';
        document.getElementById('image-container').style.display = 'none';
        document.getElementById('winner-image').src = winner.src;
        document.getElementById('winner-name').innerText = winner.name;
    }

    // 페이지 로드 시 이미지 가져오기
    loadImages();
    
    </script>

</body>
</html>
