// Controller before a person is logged in

(function(){

  angular
    .module('prinit')
    .controller('MainController', MainController);

    MainController.$inject = ['$resource'];


  function MainController($resource){

    var self = this;

    self.test = "prinit ok im in it!";
    
    var Image = $resource("http://localhost:3000/api/images/:id", {id: "@_id"});

    self.imageList = getImages();

    // self.addAlbum = addAlbum;
    // self.deleteAlbum = deleteAlbum;
  

    // INDEX - view all todos
    function getImages(){

      return Image.query();
   
    }            


  }

})();