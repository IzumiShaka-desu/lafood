<?php namespace App\Models;

use CodeIgniter\Model;

class Auth_model extends Model{
    protected $table='account';
    public function login($email,$password)
 {
       $result=$this->db->table($this->table)->getWhere(['email'=>$email,"password"=>sha1($password)])->getRowArray();
       if($result!=NULL){
        return[
            "message"=>"login berhasil",
            "result"=>true,
            "data"=>$result

        ];
       }else{
        return[
            "message"=>"login gagal",
            "result"=>false,
            "data"=>[]
        ];
       }
    }
    
public function register($email,$password,$nama,$phone,$dob)
{
    
    $result=$this->db->table($this->table)->getWhere(['email'=>$email])->getRowArray();
  if($result!=NULL){
    return [
        'result'=>false,
        'message'=>'email telah digunakan',
    ];
  }
  
  else{ 
      $result=$this->db->table($this->table)->insert([
      "email"=>$email,
      "nama"=>$nama,
      "DOB"=>$dob,
      "phone"=>$phone,
      "password"=>sha1($password)
  ]);
  if($result){
    return [
        'result'=>true,
        'message'=>'register berhasil, silahkan login',
    ];
  }else{
    return [
        'result'=>true,
        'message'=>'register gagal',
    ];
  }

}
}
}
