$(function () {
	const links = document.querySelectorAll(".menuLink");

	links.forEach(link => {
		link.onclick = function() {
			link = this.textContent;
			console.log(link);
		}
	});
});