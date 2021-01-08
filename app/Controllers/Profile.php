<?php 
namespace App\Controllers;

use CodeIgniter\RESTful\ResourceController;
use EmptyIterator;

class Profile extends ResourceController{
    
    protected $modelName="App\Models\Profile_model";
    protected $format="json";
    public function profile($id){
      return $this->respond($this->model->getProfile($id));
    }
  
}