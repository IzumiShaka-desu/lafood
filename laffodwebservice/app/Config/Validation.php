<?php namespace Config;

class Validation
{
	//--------------------------------------------------------------------
	// Setup
	//--------------------------------------------------------------------

	/**
	 * Stores the classes that contain the
	 * rules that are available.
	 *
	 * @var array
	 */
	public $ruleSets = [
		\CodeIgniter\Validation\Rules::class,
		\CodeIgniter\Validation\FormatRules::class,
		\CodeIgniter\Validation\FileRules::class,
		\CodeIgniter\Validation\CreditCardRules::class,
	];

	/**
	 * Specifies the views that are used to display the
	 * errors.
	 *
	 * @var array
	 */
	public $templates = [
		'list'   => 'CodeIgniter\Validation\Views\list',
		'single' => 'CodeIgniter\Validation\Views\single',
	];
	public  $auth=[
		'email'=>'required',
		'password'=>'required'
	];
	public $auth_errors=[
		'email'=>'email wajib diisi',
		'password'=>'password perlu diisi'
	];
	public  $kategori=[
		'nama_kategori'=>'required'
	];
	public $kategori_errors=[
		'nama_kategori'=>'Nama kategori wajib diisi'
	];
	public $news=[
		"title" =>'required',
		"id_kategori" => 'required',
		"foto" => 'required',
		"id_user" => 'required',
		"tanggal_dibuat" => 'required',
		"konten_berita" => 'required',
	];
	public $news_errors=[
		"title" =>'required',
		"id_kategori" => 'required',
		"foto" => 'required',
		"id_user" => 'required',
		"tanggal_dibuat" => 'required',
		"konten_berita" => 'required',
	];
	//--------------------------------------------------------------------
	// Rules
	//--------------------------------------------------------------------
}
