<?php

namespace App\Models;

use CodeIgniter\Model;

class Profile_model extends Model
{
    protected $table = "account";
    public function getProfile($id_user)
    {
        return $this->db->table($this->table)->getWhere(["id_user" => $id_user])->getFirstRow();
    }
}
