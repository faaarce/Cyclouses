import Vapor

func routes(_ app: Application) throws {
 
  // Root route now uses the same handler as the /product route
  app.get(use: ProductController.getProducts)
  app.get("product", ":id", use: ProductController.getProductById)
  // Product route (now identical to root route)
  app.get("product", use: ProductController.getProducts)
  
  // Auth routes
  let authGroup = app.grouped("auth")
  app.post("auth", "login", use: AuthController.login)
  
  // Cart routes (protected by auth middleware)
  let cartGroup = app.grouped(AuthMiddleware())

  cartGroup.post("cart", "add", use: CartController.addToCart)
  cartGroup.post("auth", "logout", use: AuthController.logout)
  cartGroup.get("cart", use: CartController.getCart)
  cartGroup.post("checkout", use: CheckoutController.checkout)
  cartGroup.get("orders", use: OrderHistoryController.getOrderHistory)
}
