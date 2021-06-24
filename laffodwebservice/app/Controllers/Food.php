<?php

namespace App\Controllers;

use CodeIgniter\RESTful\ResourceController;

class Food extends ResourceController
{
    protected $modelName = 'App\Models\Food_model';
    protected $format = 'json';
    function index()
    {
        return $this->respond($this->model->getListFood(), 200);
    }
    public function foodByUser($idUser)
    {
        if ($idUser != null) {
            return $this->respond($this->model->getFoodById($idUser) ?? [], 200);
        }
    }

    public function create()
    {
        $data = [
            "name" => $this->request->getPost('name'),
            "ingredients" => $this->request->getPost('ingredients'),
            "photo" => '-',
            "id_user" => $this->request->getPost('id_user'),
            "price" => $this->request->getPost('price'),
            "variant" => $this->request->getPost('variant'),
        ];

        $image = $this->request->getFile('image');
        $data['photo'] = $image->getRandomName();
        $image->move(ROOTPATH . 'public/images', $data['photo']);
        if ($this->model->addFood($data)) {
            $response = [
                'status' => 200,
                'error' => false,
                'data' => ['message' => 'success add food']
            ];
            return $this->respond($response, 200);
        } else {
            $response = [
                'status' => 500,
                'error' => true,
                'data' => ['message' => 'not success add food']
            ];
            return $this->respond($response, 200);
        }
    }
    public function delete($id = Null)
    {
        if ($id !== Null) {
            if ($this->model->deleteFood($id)) {
                $response = [
                    'status' => 200,
                    'error' => false,
                    'data' => ['message' => 'food with id : ' . $id . ' has been deleted']
                ];
                return $this->respond($response, 200);
            } else {
                $response = [
                    'status' => 500,
                    'error' => true,
                    'data' => ['message' => 'not success delete food']
                ];
                return $this->respond($response, 200);
            }
        }
    }
    public function update($id = NULL)
    {
        if ($id !== NULL)
            $data = [
                "name" => $this->request->getPost('name'),
                "ingredients" => $this->request->getPost('ingredients'),
                "photo" => $this->request->getPost('photo'),
                "id_user" => $this->request->getPost('id_user'),
                "price" => $this->request->getPost('price'),
                "variant" => $this->request->getPost('variant'),
            ];

        if ($this->request->getFile('image') !== NULL) {
            $image = $this->request->getFile('image');

            $image->move(ROOTPATH . 'public/images', $data['photo'], true);
        }
        if ($this->model->editFood($id, $data)) {
            $response = [
                'status' => 200,
                'error' => false,
                'data' => ['message' => 'success edit food with id: ' . $id . '']
            ];
            return $this->respond($response, 200);
        } else {
            $response = [
                'status' => 500,
                'error' => true,
                'data' => ['message' => 'not success edit food']
            ];
            return $this->respond($response, 200);
        }
    }
}
