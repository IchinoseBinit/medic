const _url = "http://10.0.2.2";
// const _url = "http://192.168.7.32:3001";
const _baseUrl = "$_url:3001";

const _users = "$_baseUrl/users";

const registerUrl = _users;
const loginUrl = "$_users/login_user";
const profileUrl = "$_users/profile";

const medicalStaffUrl = "$_baseUrl/medical-staff";

const companyUrl = "$_baseUrl/company";

const educationUrl = "$_baseUrl/education";

const productsUrl = "$_baseUrl/product";
const latestProductsUrl = "$productsUrl/products";
const singleProductUrl = "$_baseUrl/product?id=";

const orderUrl = "$_baseUrl/order";
// medical-staff  
