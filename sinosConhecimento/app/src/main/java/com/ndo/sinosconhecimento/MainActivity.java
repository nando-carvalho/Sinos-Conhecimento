package com.ndo.sinosconhecimento;

import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import org.json.JSONObject;
import java.util.HashMap;
import java.util.Map;


public class MainActivity extends AppCompatActivity {
    //Variavel que recebe o endereço de acesso ao WebService que se encontra no AWS da amazon.
    String urlWebServicesDesenvolvimento = "http://ec2-18-228-192-48.sa-east-1.compute.amazonaws.com/sinosconhecimento/api/user/autenticar.php";//ip do meu pc

    //Variaveis da biblioteca volley para proporcionar a comunicação HTTP
    RequestQueue requestQueue;
    StringRequest stringRequest;

    //Criação das variaveis que representam os campos da tela e login
    Button btnEntrar;
    EditText idEmail;
    EditText idSenha;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        requestQueue = Volley.newRequestQueue(this);
        //pega os eventos realizados na view.
        btnEntrar = findViewById(R.id.btnEntrar);
        idEmail = findViewById(R.id.idEmail);
        idSenha = findViewById(R.id.idSenha);

        //Função iniciada quando o botão de entrar for clicado
        btnEntrar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                boolean internet = isOnline();
                if (internet) {
                    boolean validado = true;

                    if (idEmail.getText().length() == 0) {
                        idEmail.setError("Campo e-mail é Obrigatório!");
                        idEmail.requestFocus();
                        validado = false;
                    }

                    if (idSenha.getText().length() == 0) {
                        idSenha.setError("Campo senha é obrigatório!");
                        idEmail.requestFocus();
                        validado = false;
                    }

                    if (validado) {
                        Toast.makeText(getApplicationContext(),"Realizando a autenticação. Favor, aguarde!", Toast.LENGTH_SHORT).show();
                        autenticarUsuario();
                    }
                }else{
                    Toast.makeText(getApplicationContext(),"Para autenticar você deve estar conectado à internet!", Toast.LENGTH_LONG).show();
                }
            }
        });
    }

    /**
     * Função criada para verificar se o usuário está conectado à internet.
     * @return boolean true se existe conectividade ou false se nao tiver
     */
    public boolean isOnline() {
        ConnectivityManager cm =
                (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);
        NetworkInfo netInfo = cm.getActiveNetworkInfo();
        return netInfo != null && netInfo.isConnected();
    }

    /**
     * Função criada para autenticar o acesso do usuário. Retorna um objeto.
     */
    private void autenticarUsuario() {
        stringRequest = new StringRequest(Request.Method.POST, urlWebServicesDesenvolvimento,
                new Response.Listener<String>() {
                    @Override
                    public void onResponse(String response) {
                        Log.v("LogLogin", response);

                        try {
                            Log.v("LogLogin", response);
                            //Recuperar os dados vindos do Webservice que estão em response
                            JSONObject jsonObject = new JSONObject(response);
                            boolean isErro = jsonObject.getBoolean("status");
                            String message = jsonObject.getString("message");
                            if (!isErro){//se ocorrer algum erro ele vai trazer false
                                Toast.makeText(getApplicationContext(), message, Toast.LENGTH_LONG).show();
                            }else{
                                int perfil = jsonObject.getInt("tipoUsuario");
                                if (perfil == 1){
                                    Intent telaInicial = new Intent(MainActivity.this, TelaInicialAdministradorActivity.class);
                                    startActivity(telaInicial);
                                    finish();
                                }else if(perfil == 2){
                                    Intent telaInicial = new Intent(MainActivity.this, TelaInicialAlunoActivity.class);
                                    startActivity(telaInicial);
                                    finish();
                                }
                            }

                        }catch (Exception e){
                            Log.v("LogLogin", response);

                        }
                    }
                },
                new Response.ErrorListener() {
                    @Override
                    public void onErrorResponse(VolleyError error) {
                        Log.e("LogLogin", error.getMessage());
                    }
                }) {
            @Override
            protected Map<String, String> getParams() {
                Map<String, String> params = new HashMap<>();
                params.put("email", idEmail.getText().toString());
                params.put("senha", idSenha.getText().toString());
                return params;
            }
        };
        requestQueue.add(stringRequest);
    }
}
