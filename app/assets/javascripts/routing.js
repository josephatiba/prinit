(function(){

  // routing for my SPA app :-)

  angular
    .module("prinit")
    .config(config)
    .run(run);

    function config($routeProvider, $locationProvider){

      // Define the routes 
      $routeProvider

      .when('/', {
        title: 'prinit: Prinit and sell images that you love!',
        templateUrl: 'index.html',
        controller: 'MainController',
        controllerAs: 'main'
      })

      .otherwise({
        redirectTo: '/'
      });

    }

    // rootScope is the top layer of the module
    function run($location, $rootScope){
      
      var changeRoute = function(event, current, previous){
        return $rootScope.title = current.$$route.title;
      }

      $rootScope.$on('$routeChangeSucess', changeRoute);
    }


})();