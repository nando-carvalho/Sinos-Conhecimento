package com.ndo.sinosconhecimento;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class TelaInicialAlunoActivity extends AppCompatActivity {

    Button btnSair;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_tela_inicial_aluno);

        btnSair = findViewById(R.id.btnSair);
        //a partir do evento clicar no botão sair, ele volta para tela de login.
        btnSair.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent home = new Intent(TelaInicialAlunoActivity.this, MainActivity.class);
                startActivity(home);
                finish();
            }
        });

    }
}
