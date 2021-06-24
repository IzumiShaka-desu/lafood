<?php namespace App\Controllers;

use CodeIgniter\Config\Services;
use CodeIgniter\RESTful\ResourceController;

class Kategori extends ResourceController{
    protected $modelName = 'App\Models\Kategori_model';
    protected $format = 'json';
    function index()
    {
        return $this->respond($this->model->findAll(),200);
    }
    public function create()
    {
        $data=[
            'nama_kategori'=>$this->request->getPost('nama_kategori')
        ];
        $validation=Services::validation();
    if($validation->run($data,'kategori')==FALSE){
        $response = [
            'status' => 500,
            'error' => true,
            'data' => $validation->getErrors(),
        ];
        return $this->respond($response, 500);
    }else {
        $simpan = $this->model->addKategori($data);
    
        if($simpan){
            $msg = ['message' => 'Add kategori successfully'];
            $response = [
                'status' => 200,
                'error' => false,
                'data' => $msg,
            ];
            return $this->respond($response, 200);
        }
    }
        
    }
    public function update($id=NULL)
    {
        $data=[
            'nama_kategori'=>$this->request->getPost('nama_kategori')
        ];
        $validation=Services::validation();
    if($validation->run($data,'kategori')==FALSE){
        $response = [
            'status' => 500,
            'error' => true, 
            'data' => $validation->getErrors(),
        ];
        return $this->respond($response, 500);
    }else {
        $simpan = $this->model->updateKategori($data,$id);
        if($simpan){
            $msg = ['message' => 'Update kategori successfully'];
            $response = [
                'status' => 200,
                'error' => false,
                'data' => $msg,
            ];
            return $this->respond($response, 200);
        }
    }
    }
}