package bitcamp.chopchop.domain;

import java.sql.Date;

public class Cart {
  private int cartNo;
  private int memberNo;
  private int productNo;
  private int quantity;
  private Date createdDate;

  public int getCartNo() {
    return cartNo;
  }

  public void setCartNo(int cartNo) {
    this.cartNo = cartNo;
  }

  public int getMemberNo() {
    return memberNo;
  }

  public void setMemberNo(int memberNo) {
    this.memberNo = memberNo;
  }

  public int getProductNo() {
    return productNo;
  }

  public void setProductNo(int productNo) {
    this.productNo = productNo;
  }

  public int getQuantity() {
    return quantity;
  }

  public void setQuantity(int quantity) {
    this.quantity = quantity;
  }

  public Date getCreatedDate() {
    return createdDate;
  }

  public void setCreatedDate(Date createdDate) {
    this.createdDate = createdDate;
  }

  @Override
  public String toString() {
    return "Cart [cartNo=" + cartNo + ", createdDate=" + createdDate + ", memberNo=" + memberNo + ", productNo="
        + productNo + ", quantity=" + quantity + "]";
  }

}
