package bitcamp.chopchop.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import bitcamp.chopchop.domain.Cart;
import bitcamp.chopchop.domain.Member;
import bitcamp.chopchop.service.CartService;
import bitcamp.chopchop.service.MemberService;

@Controller
@RequestMapping("/cart")
public class CartController {

  @Resource
  private CartService cartService;
  @Resource
  private MemberService memberService;
  

  @GetMapping("form")
  public void form() {
  }

  @GetMapping("list")
  public void list(Model model) throws Exception {
    model.addAttribute("carts", cartService.list());
  }

  @PostMapping("add")
  public String add(Cart cart, Model model) throws Exception {

    cartService.insert(cart);
    model.addAttribute("cart", cart);
    return "redirect:../cart/detail?no=" + cart.getCartNo();
  }

  // button delete
  @GetMapping("delete")
  public String delete(int no, HttpServletRequest request) 
      throws Exception {
    cartService.delete(no);
    return "redirect:search";
  }

  // checkbox delete controller
@GetMapping("chkdelete")
public String chkdelete(HttpSession session,
     @RequestParam Map<String, String> paramMap, Cart cart) throws Exception {
 
      String[] arrIdx = paramMap.get("chkbox").toString().split(",");
      for (int i = 0; i < arrIdx.length; i++) {
          cartService.delete(Integer.parseInt(arrIdx[i]));
      }
      return "redirect:search";
}

  @GetMapping("detail")
  public void detail(Model model, int no) throws Exception {
    model.addAttribute("cart", cartService.get(no));
  }

  @GetMapping("search")
  public void search(Model model, HttpSession session) throws Exception {
    Member member = (Member) session.getAttribute("loginUser");
    List<Cart> carts = cartService.search(Integer.toString(member.getMemberNo()));
    model.addAttribute("carts", carts);
  }

  @PostMapping("update")
  public String update(Cart cart, HttpServletRequest request) 
      throws Exception {
    cartService.update(cart);
    return "redirect:search";
  }

  // 테스트용
  @GetMapping("test")
  public void test(Model model, HttpSession session) throws Exception {
    Member member = (Member) session.getAttribute("loginUser");
    System.out.println(member.getMemberNo());
    List<Cart> carts = cartService.search(Integer.toString(member.getMemberNo()));

    // Member member = memberService.get(no);
    model.addAttribute("carts", carts);
  }
}


