<?php

namespace App\Models;

use CodeIgniter\Model;

class Fav_model extends Model
{
    protected $table = "favorite";
    public function getFav($id_user)
    {
        return $this->db->table($this->table)->getWhere(["id_user" => $id_user])->getResultArray();
    }
    public function updateFav($data)
    {
        $count = $this->db->query('select COUNT(id_food) as a from favorite where id_user=' . $data['id_user'] . ' And id_food=' . $data['id_food'].' ')->getRowArray();
        if ($count['a'] > 0) {
            return $this->db->table($this->table)->delete($data);
        }
        return $this->db->table($this->table)->insert($data);
    }
}
