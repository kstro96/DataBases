
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package splitpay;

import Controladores.CuentaJpaController;
import Controladores.DeudaJpaController;
import Controladores.TransaccionJpaController;
import Controladores.UsuarioJpaController;
import Negocio.Deuda;
import Negocio.DeudaPK;
import Negocio.TransaccionPK;
import java.util.List;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

/**
 *
 * @author Pablo
 */
public class SplitPay {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("SplitPayPU");
        UsuarioJpaController contro = new UsuarioJpaController(emf) ;
        //contro.signIn( "hola","12345" );     
        DeudaPK deuda;
        deuda = new DeudaPK(2, (long)1, (short)1);
        
        
        TransaccionJpaController controTrans = new TransaccionJpaController(emf);
        System.out.println( controTrans.memberToMemberTrans( deuda.getUsuarioId(), deuda.getCuentaId(), deuda.getIdDeuda(), 50000, 'C') );
        
        
        System.out.println(" Hola Mundo") ;
        int idGrupo = 1 ;
        int idUsu= 1 ;
        CuentaJpaController controCuenta = new CuentaJpaController(emf);
       // controCuenta.GruposdeUsuario(idUsu);
       // List<String>usu=contro.UsuariosdeGrupo(idGrupo);
     /*  controCuenta.RealizarBalanceGruposdeUsuario();*/
    }
}
