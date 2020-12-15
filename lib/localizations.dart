import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'appName': 'tabdeel',
      'appNameShort': 'tabdeel',
      "home": "Home",
      "next": "Next",
      "driverphone": "Contact the driver",
      "locationMap": "Locate you on the map",
      "searchplace": "Search for a place",
      "searchstor": "Search for stores on the map",
      "searchhimstor": "Find stores here",
      "search": "Search",
      "shoponer": "The shop owner",
      "email": "EMail",
      "phone": "Phone",
      "shoprate": "Shop evaluation",
      "addrate": "Add a rating",
      "addcomment": "Write a comment",
      "evaluation": "Evaluation",
      "start": "Start",
      "replaceorder": "Ready to replace your order",
      "orders": "Orders",
      "dateorder": "date the order",
      "offers": "Offers",
      "notifications": "Notifications",
      "message": "Messages",
      "shop": "Shop",
      "order_details": "ORder details",
      "oldsize": "Old size",
      "newsize": "New size",
      "ordercolor": "Order color",
      "from": "From",
      "to": "To",
      "subshop": "Sub Shops",
      "clientrate": "Client evaluation",
      "clientsite": "Client location",
      "shoplocation": "Shop location",
      "followmap": "Follow on map",
      "nots": "Notes",
      "imagbill": "Copy of the bill",
      "ordercost": "Order cost",
      "ordercancel": "Order cancel",
      "driverrate": "Driver evaluation",
      "driverchat": "Contact the driver",
      "orderaccept": "The order has been connected",
      "orderend": "The order has been ended",
      "writemessage": "Write your message",
      "notconnect": "There is no internet connection",
      "loading": "Loading...",
      "terms": "Terms and conditions",
      "suport": "Support",
      "logout": "Logout",
      "languge": "language",
      "noshop": "There are no stores",
      "addorder": "Create order",
      "addordersuccess": "product added successfully. Please wait accept",
      "determinmap": "Follow on the map",
      "confirmorder": "Confirm sending order ?",
      "deletorder": "Delete an order",
      "notyet": "Other than that",
      "willreplaced:":"Will be replaced:",
      "mony": "deserved amount",
      "replace": "Replace",
      "prodname": "Product name",
      "clientchat": "Contact the client",
      "orderordycancel": "This order has already been canceled",
      "currentOder": "Current Orders",
      "acceptorder": "Accepted Orders",
      "confirmacceptorder": "Confirm accepted order",
      "enforder": "Completed Orders",
      "delivery": "Delivery ",
      "stores": "Shops",
      "confirm": "Confirmation",
      "no": "No",
      "yes": "Yes",
      "endoreders": "Order has been Ended",
      "addimagebill":
          "Attach a copy of the invoice to confirm the order has been completed.",
      "cancelorders": "Cancelling Order",
      "acceptorders": "'Oreder Accept",
      "endedorders": "Ending Order",
      "confirmcancel": "Confirm cancellation of the order?",
      "sucessrate": "The evaluation was successful",
      "adressshop": "Store Address",
      "skap": "Skip",
      "addressthree":
          "A replacement that guarantees your rights 100%, whether for the customer or the representative",
      "addresstwo": "Continue retrieving products through the control panel",
      "addressone":
          "Returning and exchanging products is now easier with Switch  ",
      "technecal": "Technical support",
      "send": "Send",
      "addressubject": "Topic title",
      "name": "Name",
      "forgotpass": "Forgot password",
      "accounttype": "Account type",
      "driver": "Driver",
      "client": "Client",
      "noaccount": "You don't have an account yet",
      "password": "Password",
      "mobile": "Mobile",
      "carback": "image of car from behind",
      "cellimag": "Attach a copy of the license",
      "enternumber": "Enter the number",
      "ids": "ID or residence number",
      "frontcar": "image of car from the front",
      "imagenation": "Attach the identity photo",
      "nationality": "Nationality",
      "appcondation": "Conditions of application",
      "iagree": "By clicking on this button, I agree to",
      "accept":"Accept",
       "creataccount":"Create account",
       "country":"Country",
       "regster":"Register",
       "creataccount":"Create Account",

       "costdelvered":"Delivery cost:",

        "termsone":"Switch is the first application that acts as an intermediary between the representative and the customer in exchanging or retrieving clothes and shoes",
      "termstwo":"When the application is used by the delegate and the customer will be subject to the following conditions",
      "termsthree":"1- When using the application from any party, it means consent from the user to abide by these terms and conditions",
      "termsfour":"2- The application is not responsible for the delegate’s failure to deliver purchases on time and their safety from any damages and hand them over to the customer. The delegate bears all the responsibilities for that.",
      "termsfive":"3- Purchases exchanged or returned from the store system from which the goods are purchased according to the system of the Ministry of Commerce are subject to 3 days for returns and one week for returns.",
      "termssix":"4- The delegate shall abide by the conditions of application and fill in the necessary data in the fields of application such as name, ID number, form image and vehicle pictures, and the information shall be correct.",
      "termsseven":"5- Upon the completion of the request process from the client and the delegate’s acceptance of it, this represents an agreement between the customer and the delegate. The responsibility rests with the delegate in completing the process.",
      "termseight":"6- The customer must attach a clear copy of the invoice to the date specified for replacement and return",
      "termsnine":"7- The delegate is obliged to retrieve and exchange the goods at the specified time and for the price specified in the application and any violation to that effect the delegate and the application is not responsible for",
      "termsten":"8- Coordination takes place between the delegate and the customer upon receiving the goods and determining the delivery amount by the delegate according to the application system and the delegate is responsible for that.",
      "termssone":"9- The administration of the application has the right to amend, delete or add any of the conditions, and the delegate or any person has no right to object to it",
      "termsstwo":"10 - The customer is obliged to pay the agreed value of the service in case of violating the date or the replacement and return policy of the store policy",
      "termssthree":"11- The delegate is obliged to pay 25% of the value of one application",


      "termssfour":"12- When the delegate fails to pay to apply, the application has the right to suspend his account",
     "termssfive":"13- If the delegate gets a bad evaluation and repeated three times from the clients, the application has the right to suspend his account",
     "termsssix":"14- Upon the client’s approval of the representative’s offer at the price and the specified time, he is not entitled to cancel after five minutes have passed, he will bear the value of the service.",
     "termssseven":"15- Upon return, the delegate shall return the amount due on the invoice to the customer",
     "termsseight":"16 - Any dispute arises between any of the parties applying the system in force in the Kingdom of Saudi Arabia",
     "termssnine":"17- All intellectual property rights for this platform and all related materials are proprietary to implement a change and he has the right to dispose of this property as he pleases.",
     "termssten":"18 - We totally reject any offensive language or bad behavior towards the company or service we provide, whether from the customer or the delegate, and we have the right to close the accounts without paying any amounts due, and we reserve the right to the law to protect our interests", 
      "login":"Login",
      "timedend":"Enter the time to end the request in minutes",
      "addprodect":"Add a product",
      "deletdproduct":"Delete a product",
      "costhisorder":"Cost for delivery of this order:"
          },
    'ar': {
      "costhisorder":"تكلفة توصيل هذا الطلب  : ",
      "deletdproduct":"حذف منتج ",
      "addprodect":"أضافة منتج",
        "timedend":"أدخل وقت انهاء الطلب بالدقيقة",
      "login":"دخول",
      "termsfive":"3-	تخضع المشتريات المبدله او المسترجعة من نظام المتجر المشترى منه البضاعة حسب نظام وزارة التجارة  3 أيام للاسترجاع واسبوع للترجيع ",
      "termssix":"4-	 يلتزم المندوب بالتقيد بشروط التطبيق وتعبئة ما يلزم من بيانات في حقول التطبيق مثل الاسم ورقم الهوية وصورة الاستمارة وصور السيارة  ويلتزم ان تكون المعلومات صحيحة ",
      "termsseven":"5-	عند اتمام عملية الطلب من العميل وقبول المندوب لها فان هذا يمثل اتفاق بين العميل والمندوب وتقع المسؤولية على المندوب في اتمام العملية ",
      "termseight":"6-	على العميل ان يرفق صورة من الفاتورة واضحة بالتاريخ المحدد للاستبدال والاسترجاع ",
      "termsnine":"7-	يلتزم المندوب باسترجاع وتبديل البضاعة في الوقت المحدد وبالثمن المحدد في التطبيق واي مخالفة لذلك يتحمل المندوب والتطبيق غير مسؤول عنها ",
      "termsten":"8-	 يتم التنسيق بين المندوب والعميل عند استلام البضاعة وتحديد مبلغ التوصيل من قبل المندوب حسب نظام التطبيق والمندوب مسؤول عن ذلك ",
      "termssone":"9-	يحق لادارة التطبيق تعديل او حذف او اضافة أي شرط من الشروط ولا يحق للمندوب اوي أي شخص الاعتراض عليه ",
      "termsstwo":"10-  يلتزم العميل بدفع قيمة الخدمة المتفق عليها في حال مخالفة التاريخ او سياسة الاستبدال والترجيع لسياسة المتجر",
     "termssthree":"11- يلتزم المندوب بدفع 25 % من قيمة الطلب الواحد ",
     
     "termssfour":"12- عند عدم التزام المندوب بالدفع للتطبيق يحق للتطبيق ايقاف حسابه",
     "termssfive":"13- اذا حصل المندوب على تقييم سيء وتكررت ثلاث مرات من العملاء يحق للتطبيق ايقاف حسابه",
     "termsssix":"14- عند موافقة العميل على عرض المندوب بالسعر والوقت المحدد لا يحق له الالغاء بعد مضي خمس دقائق يتحمل قيمة الخدمة ",
     "termssseven":"15- عند الترجيع يلتزم المندوب بارجاع المبلغ المستحق المسجل في الفاتورة للعميل ",
     "termsseight":"16 – أي خلاف ينشأ بين أي طرف من الاطراف يطبق النظام المعمول به في المملكة العربية السعودية",
      "termssnine":"17- جميع حقوق الملكية الفكريه لهذه المنصه وكافة المواد المتعلقة بها هي ملكيه خاصة لتطبيق تبديل ويحق له التصرف في هذه الملكية كما يشاء",
      "termssten":"18 – نرفض بشكل كامل أي لغة مسيئة او سلوك سيء تجاه الشركة او الخدمة التي نقدمها سواء من العميل او المندوب ويحق لنا اغلاق الحسابات دون دفع أي مبالغ مستحقة ، ونحتفظ بحقنا القانون لحماية مصالحنا ",
      "creataccount":"أنشاء حساب",
      "regster":"تسجيل",
      "country":"المدينة",
      "creataccount":"أنشاء حساب",
      "accept":"موافق",
      "iagree": "بالنقر على هذا الزر اكون وافقت على",
      "appcondation": "شروط التطبيق",
      "password": "كلمة المرور",
      "mobile": "رقم الهاتف",
      "carback": "صورة السيارة من الخلف",
      "cellimag": "ارفاق صورة الرخصة",
      "enternumber": "قم بادخال الرقم",
      "ids": "رقم الهوية او الأقامة",
      "frontcar": "صورة السيارة من الامام",
      "imagenation": "ارفاق صورة الهوية",
      "nationality": "الجنسية",
      "noaccount": "لا تمتلك حساب سجل الان",
      "accounttype": "نوع الحساب",
      "driver": "مندوب",
      "client": "عميل",
      "forgotpass": "نسيت كلمة المرور",
      "technecal": "الدعم الفني",
      "adressshop": ":عنوان المحل",
      "skap": "تخطي",
      "addressthree": "تبديل يضمن لك حقوقك بنسبة %100 سواء للعميل او المندوب",
      "addresstwo": "تابع استرجاع المنتجات من خلال لوحة التحكم",
      "addressone": "استرجاع المنتجات واستبدالها اصبح اسهل الان مع تبديل",
      "sucessrate": "تم التقييم بنجاح",
      "endoreders": "تم انهاء الطلب",
      "confirmcancel": "تأكيد إلغاء الطلب ؟",
      "cancelorders": "إلغاء الطلب",
      "acceptorders": "'قبول الطلب",
      "endedorders": "إنهاء الطلب",
      "confirmacceptorder": "تم قبول الطلب",
      "addimagebill": "قم بإرفاق صورة الفاتورة لتأكيد أنهاء الطلب .",
      "endorders": "تم إنهاء الطلب",
      "yes": "نعم",
      "no": "لا",
      "confirm": "تأكيد",
      "stores": "المتاجر",
      "costdelvered":"تكلفة التوصيل :",
      "delivery": "التوصيلات ",
      "clientchat": "مراسلة العميل",
      "clientrate": "تقييم العميل ",
      "prodname": "اسم المنتج",
      "name":"الاسم",
      "replace": "استيدال",
      "mony": "المبلغ المستحق",
      "willreplaced": "سيتم استبدال:",
      "deletorder": "حذف الطلب",
      "addordersuccess": "تمت اضافة المنتج بنجاح الرجاء انتظار قبول الطلب",
      "driverphone": "اتصال بالمندوب",
      "terms": "الشروط والأحكام",
      'appName': 'تبديل',
      'appNameShort': 'تبديل',
      "home": "الرئيسية",
      "determinmap": "تتبع علي الخريطة",
      "next": "التالي",
      "locationMap": "حدد موقعك علي الخريطة",
      "searchplace": "ابحث عن مكان",
      "searchstor": "ابحث عن متاجر ف الخريطة",
      "searchhimstor": "ابحث عن متاجر هنا",
      "search": "بحث",
      "shoponer": "صاحب المحل",
      "email": "البريد الالكتروني",
      "phone": "رقم الهاتف",
      "shoprate": "تقييم المحل",
      "addrate": "إضافة تقييم",
      "addcomment": "كتابة التعليق",
      "evaluation": "تقييم",
      "start": "ابدأ",
      "replaceorder": "جاهز لأستبدال طلبك",
      "orders": "الطلبات",
      "dateorder": "تاريخ أنشاء الطلب",
      "offers": "العروض",
      "notifications": "التنبيهات",
      "message": "الرسائل",
      "shop": "محل",
      "order_details": "تفاصيل الطلب",
      "oldsize": "المقاس القديم",
      "newsize": "المقاس الجديد",
      "ordercolor": "لون المنتج",
      "from": "من",
      "to": "إلي",
      "clientsite": "موقع العميل",
      "shoplocation": "موقع المحل",
      "followmap": "متابعة علي الحريطة",
      "nots": "الملاحظات",
      "imagbill": "صورة الفاتورة",
      "ordercost": "تكلفة الطلب",
      "ordercancel": "الغاء الطلب",
      "driverrate": "تقييم المندوب",
      "driverchat": "مراسلة المندوب",
      "orderaccept": "تم توصيل الطلب",
      "orderend": "تم أنهاء الطلب",
      "writemessage": "اكتب رسالتك",
      "notconnect": "لا يوجد اتصال بالانترنت",
      "loading": "جاري التحميل....",
      "suport": "الدعم",
      "logout": "تسجيل الخروج",
      "languge": "اللغة",
      "noshop": "لا يوجد محلات",
      "addorder": "أنشاء طلب",
      "allrequerd": "كل البيانات مطلوبه",
      "confirmorder": "تأكيد إرسال الطلب ؟",
      "notyet": "غير ذلك",
      "subsop": "المتاجر الفرعية",
      "orderordycancel": "لقد تم  إلغاء هذا الطلب من قبل",
      "currentOder": "الطلبات الحالية",
      "acceptorder": "الطلبات المقبولة",
      "enforder": "الطلبات المنتهية",
      "termsone":"تبديل هو أول تطبيق يعمل كوسيط بين المندوب والزبون في تبديل الملابس والاحذية او استرجاعها",
      "termstwo":"عند استخدام التطبيق من قبل المندوب والزبون ستكون خاضعة للشروط التالية",
      "termsthree":"1-	عند استخدام التطبيق من أي جهة كانت يعني الموافقة من المستخدم بالالتزام بهذا الشروط والاحكام",
      "termsfour":"2-	 التطبيق غير مسؤول عن تقصير من المندوب في توصيل المشتريات في الوقت المحدد وسلامتها من أي اضرار ويسلمها للعميل ويتحمل المندوب كافة المسؤوليات لذلك  ",
      
      


      
    },
  };



String get costhisorder {
    return _localizedValues[locale.languageCode]['costhisorder'];
  }
String get deletdproduct {
    return _localizedValues[locale.languageCode]['deletdproduct'];
  }
String get addprodect {
    return _localizedValues[locale.languageCode]['addprodect'];
  }

 String get costdelvered {
    return _localizedValues[locale.languageCode]['costdelvered'];
  }
 String get timedend {
    return _localizedValues[locale.languageCode]['timedend'];
  } 
 String get login {
    return _localizedValues[locale.languageCode]['login'];
  } 

  String get termsone {
    return _localizedValues[locale.languageCode]['termsone'];
  } 
String get termstwo {
    return _localizedValues[locale.languageCode]['termstwo'];
  } 

    String get termsthree{
    return _localizedValues[locale.languageCode]['termsthree'];
  } 
    String get termsfour {
    return _localizedValues[locale.languageCode]['termsfour'];
  } 

    String get termsfive {
    return _localizedValues[locale.languageCode]['termsfive'];
  } 

    String get termssix {
    return _localizedValues[locale.languageCode]['termssix'];
  } 

    String get termsseven {
    return _localizedValues[locale.languageCode]['termsseven'];
  } 

    String get termseight {
    return _localizedValues[locale.languageCode]['termseight'];
  } 

    String get termsnine {
    return _localizedValues[locale.languageCode]['termsnine'];
  } 

    String get termsten {
    return _localizedValues[locale.languageCode]['termsten'];
  } 

    String get termssone{
    return _localizedValues[locale.languageCode]['termssone'];
  } 

    String get termsstwo {
    return _localizedValues[locale.languageCode]['termsstwo'];
  } 

    String get termssthree {
    return _localizedValues[locale.languageCode]['termssthree'];
  } 

    String get termssfour {
    return _localizedValues[locale.languageCode]['termssfour'];
  } 

    String get termssfive {
    return _localizedValues[locale.languageCode]['termssfive'];
  } 

    String get termsssix{
    return _localizedValues[locale.languageCode]['termsssix'];
  } 

    String get termssseven {
    return _localizedValues[locale.languageCode]['termssseven'];
  } 

    String get termsseight {
    return _localizedValues[locale.languageCode]['termsseight'];
  } 

    String get termssnine {
    return _localizedValues[locale.languageCode]['termssnine'];
  } 

    String get termssten {
    return _localizedValues[locale.languageCode]['termssten'];
  } 





    String get acceptis {
    return _localizedValues[locale.languageCode]['accept'];
  } 

  
 
  String get creataccount {
    return _localizedValues[locale.languageCode]['regster'];
  } 
  String get regster {
    return _localizedValues[locale.languageCode]['regster'];
  }
 String get country {
    return _localizedValues[locale.languageCode]['country'];
  }
  String get carback {
    return _localizedValues[locale.languageCode]['carback'];
  }
String get agree {
    return _localizedValues[locale.languageCode]['iagree'];
  }

  String get appcondation {
    return _localizedValues[locale.languageCode]['appcondation'];
  }

  String get cellimag {
    return _localizedValues[locale.languageCode]['cellimag'];
  }

  String get nationality {
    return _localizedValues[locale.languageCode]['nationality'];
  }

  String get imagenation {
    return _localizedValues[locale.languageCode]['imagenation'];
  }

  String get frontcar {
    return _localizedValues[locale.languageCode]['frontcar'];
  }

  String get enternumber {
    return _localizedValues[locale.languageCode]['enternumber'];
  }

  String get ids {
    return _localizedValues[locale.languageCode]['ids'];
  }

  String get mobile {
    return _localizedValues[locale.languageCode]['mobile'];
  }

  String get password {
    return _localizedValues[locale.languageCode]['password'];
  }

  String get noaccount {
    return _localizedValues[locale.languageCode]['noaccount'];
  }

  String get client {
    return _localizedValues[locale.languageCode]['client'];
  }

  String get driver {
    return _localizedValues[locale.languageCode]['driver'];
  }

  String get accounttype {
    return _localizedValues[locale.languageCode]['accounttype'];
  }

  String get forgotpass {
    return _localizedValues[locale.languageCode]['forgotpass'];
  }

  String get send {
    return _localizedValues[locale.languageCode]['send'];
  }

  String get name {
    return _localizedValues[locale.languageCode]['name'];
  }

  String get addressubject {
    return _localizedValues[locale.languageCode]['addressubject'];
  }

  String get technecal {
    return _localizedValues[locale.languageCode]['technecal'];
  }

  String get skap {
    return _localizedValues[locale.languageCode]['skap'];
  }

  String get addresstwo {
    return _localizedValues[locale.languageCode]['addresstwo'];
  }

  String get addressone {
    return _localizedValues[locale.languageCode]['addressone'];
  }

  String get addressthree {
    return _localizedValues[locale.languageCode]['addressthree'];
  }

  String get adressshop {
    return _localizedValues[locale.languageCode]['adressshop'];
  }

  String get sucessrate {
    return _localizedValues[locale.languageCode]['sucessrate'];
  }

  String get confirmcancel {
    return _localizedValues[locale.languageCode]['confirmcancel'];
  }

  String get confirmacceptorder {
    return _localizedValues[locale.languageCode]['confirmacceptorder'];
  }

  String get cancelorders {
    return _localizedValues[locale.languageCode]['cancelorders'];
  }

  String get acceptorders {
    return _localizedValues[locale.languageCode]['acceptorders'];
  }

  String get endedorders {
    return _localizedValues[locale.languageCode]['endedorders'];
  }

  String get addimagebill {
    return _localizedValues[locale.languageCode]['addimagebill'];
  }

  String get endoreders {
    return _localizedValues[locale.languageCode]['endoreders'];
  }

  String get confirm {
    return _localizedValues[locale.languageCode]['confirm'];
  }

  String get no {
    return _localizedValues[locale.languageCode]['no'];
  }

  String get yes {
    return _localizedValues[locale.languageCode]['yes'];
  }

  String get stores {
    return _localizedValues[locale.languageCode]['stores'];
  }

  String get delivery {
    return _localizedValues[locale.languageCode]['delivery'];
  }

  String get currentOder {
    return _localizedValues[locale.languageCode]['currentOder'];
  }

  String get acceptorder {
    return _localizedValues[locale.languageCode]['acceptorder'];
  }

  String get enforder {
    return _localizedValues[locale.languageCode]['enforder'];
  }

  String get orderordycancel {
    return _localizedValues[locale.languageCode]['orderordycancel'];
  }

  String get clientchat {
    return _localizedValues[locale.languageCode]['clientchat'];
  }

  String get clientrate {
    return _localizedValues[locale.languageCode]['clientrate'];
  }

  String get subshop {
    return _localizedValues[locale.languageCode]['subshop'];
  }

  String get prodname {
    return _localizedValues[locale.languageCode]['prodname'];
  }

  String get replace {
    return _localizedValues[locale.languageCode]['replace'];
  }

  String get mony {
    return _localizedValues[locale.languageCode]['mony'];
  }

  String get willreplaced {
    return _localizedValues[locale.languageCode]['willreplaced'];
  }

  String get notyet {
    return _localizedValues[locale.languageCode]['notyet'];
  }

  String get deletorder {
    return _localizedValues[locale.languageCode]['deletorder'];
  }

  String get confirmorder {
    return _localizedValues[locale.languageCode]['confirmorder'];
  }

  String get allrequerd {
    return _localizedValues[locale.languageCode]['allrequerd'];
  }

  String get addordersuccess {
    return _localizedValues[locale.languageCode]['addordersuccess'];
  }

  String get determinmap {
    return _localizedValues[locale.languageCode]['determinmap'];
  }

  String get driverphone {
    return _localizedValues[locale.languageCode]['driverphone'];
  }

  String get addorder {
    return _localizedValues[locale.languageCode]['addorder'];
  }

  String get logout {
    return _localizedValues[locale.languageCode]['logout'];
  }

  String get languge {
    return _localizedValues[locale.languageCode]['languge'];
  }

  String get noshop {
    return _localizedValues[locale.languageCode]['noshop'];
  }

  String get terms {
    return _localizedValues[locale.languageCode]['terms'];
  }

  String get suport {
    return _localizedValues[locale.languageCode]['suport'];
  }

  String get loading {
    return _localizedValues[locale.languageCode]['loading'];
  }

  String get notconnect {
    return _localizedValues[locale.languageCode]['notconnect'];
  }

  String get appName {
    return _localizedValues[locale.languageCode]['appName'];
  }

  String get appNameShort {
    return _localizedValues[locale.languageCode]['appNameShort'];
  }

  String get home {
    return _localizedValues[locale.languageCode]['home'];
  }

  String get next {
    return _localizedValues[locale.languageCode]['next'];
  }

  String get writemessage {
    return _localizedValues[locale.languageCode]['writemessage'];
  }

  String get orderend {
    return _localizedValues[locale.languageCode]['orderend'];
  }

  String get orderaccept {
    return _localizedValues[locale.languageCode]['orderaccept'];
  }

  String get driverchat {
    return _localizedValues[locale.languageCode]['driverchat'];
  }

  String get driverrate {
    return _localizedValues[locale.languageCode]['driverrate'];
  }

  String get ordercancel {
    return _localizedValues[locale.languageCode]['ordercancel'];
  }

  String get ordercost {
    return _localizedValues[locale.languageCode]['ordercost'];
  }

  String get imagbill {
    return _localizedValues[locale.languageCode]['imagbill'];
  }

  String get nots {
    return _localizedValues[locale.languageCode]['nots'];
  }

  String get followmap {
    return _localizedValues[locale.languageCode]['followmap'];
  }

  String get shoplocation {
    return _localizedValues[locale.languageCode]['shoplocation'];
  }

  String get clientsite {
    return _localizedValues[locale.languageCode]['clientsite'];
  }

  String get to {
    return _localizedValues[locale.languageCode]['to'];
  }

  String get from {
    return _localizedValues[locale.languageCode]['from'];
  }

  String get ordercolor {
    return _localizedValues[locale.languageCode]['ordercolor'];
  }

  String get newsize {
    return _localizedValues[locale.languageCode]['newsize'];
  }

  String get oldsize {
    return _localizedValues[locale.languageCode]['oldsize'];
  }

  String get order_details {
    return _localizedValues[locale.languageCode]['order_details'];
  }

  String get shop {
    return _localizedValues[locale.languageCode]['shop'];
  }

  String get message {
    return _localizedValues[locale.languageCode]['message'];
  }

  String get notifications {
    return _localizedValues[locale.languageCode]['notifications'];
  }

  String get offers {
    return _localizedValues[locale.languageCode]['offers'];
  }

  String get dateorder {
    return _localizedValues[locale.languageCode]['dateorder'];
  }

  String get orders {
    return _localizedValues[locale.languageCode]['orders'];
  }

  String get replaceorder {
    return _localizedValues[locale.languageCode]['replaceorder'];
  }

  String get start {
    return _localizedValues[locale.languageCode]['start'];
  }

  String get evaluation {
    return _localizedValues[locale.languageCode]['evaluation'];
  }

  String get addcomment {
    return _localizedValues[locale.languageCode]['addcomment'];
  }

  String get addrate {
    return _localizedValues[locale.languageCode]['addrate'];
  }

  String get shoprate {
    return _localizedValues[locale.languageCode]['shoprate'];
  }

  String get phone {
    return _localizedValues[locale.languageCode]['phone'];
  }

  String get email {
    return _localizedValues[locale.languageCode]['email'];
  }

  String get shoponer {
    return _localizedValues[locale.languageCode]['shoponer'];
  }

  String get search {
    return _localizedValues[locale.languageCode]['search'];
  }

  String get searchplace {
    return _localizedValues[locale.languageCode]['searchplace'];
  }

  String get searchhimstor {
    return _localizedValues[locale.languageCode]['searchhimstor'];
  }

  String get searchstor {
    return _localizedValues[locale.languageCode]['searchstor'];
  }

  String get locationMap {
    return _localizedValues[locale.languageCode]['locationMap'];
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
