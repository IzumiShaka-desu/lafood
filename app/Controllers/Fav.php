<?php

namespace App\Controllers;

use CodeIgniter\RESTful\ResourceController;
use EmptyIterator;

class Fav extends ResourceController
{

    protected $modelName = "App\Models\Fav_model";
    protected $format = "json";
    public function favorite($id)
    {
        return $this->respond($this->model->getFav($id));
    }
    public function updatefav($idUser)
    {
        $data = [
            'id_user' => $idUser,
            'id_food' => $this->request->getPost('idFood')
        ];
        if ($this->model->updateFav($data)) {
            return $this->respond(['result' => true]);
        }
        return $this->respond(['result' => false]);
    }
}
