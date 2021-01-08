<?php

namespace App\Models;

use CodeIgniter\Model;

class Food_model extends Model
{
    protected $table = 'food';
    public function getFoodById($idUser)
    {
        return $this->db->table($this->table)->getWhere(['id_user' => $idUser])->getResultArray();
    }
    public function getListFood()
    {
        return $this->db->table('view_food')->getWhere()->getResultArray();
    }
    public function addFood($food)
    {
        return $this->db->table('food')->insert($food);
    }
    public function deleteFood($id)
    {
        return $this->db->table('food')->delete(["id_food" => $id]);
    }
    public function ediFood($id, $food)
    {
        return $this->db->table('food')->update($food, ["id_food" => $id]);
    }
}
