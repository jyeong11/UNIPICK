$(document).ready(function() {
    // 프로필 이미지 미리보기
    $('#storePp').change(function() {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                $('#previewStorePp').attr('src', e.target.result).show();
            }
            reader.readAsDataURL(file);
        }
    });

    // 배경 이미지 미리보기
    $('#storeBp').change(function() {
        const file = this.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function(e) {
                $('#previewStoreBp').attr('src', e.target.result).show();
            }
            reader.readAsDataURL(file);
        }
    });

    // 이미지 삭제 버튼
    $('#removeStorePp').click(function() {
        $('#storePp').val('');
        $('#previewStorePp').hide();
    });

    $('#removeStoreBp').click(function() {
        $('#storeBp').val('');
        $('#previewStoreBp').hide();
    });
}); 