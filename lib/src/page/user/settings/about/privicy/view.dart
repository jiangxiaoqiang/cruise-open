import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'state.dart';

Widget buildView(PrivicyState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    body: SafeArea(
      child: Container(
          child: SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Text('''修订日期：2020 年 08 月 07 日
                  Tell 是一个以消解烦恼为主题的信息和意见交换平台，由深圳谨启科技有限公司拥有和运营。当您使用 Tell 提供的服务时，即表示您信赖我们对您信息的处理方式。我们深知这项责任事关重大，因此会始终致力于保护您的信息，并让您享有控制权。
                  本隐私政策旨在协助您了解我们会收集哪些信息、如何存储和使用这些信息，以及您如何更新、管理和删除自己的信息。我们会根据您的同意和其它可处理您个人信息的法律依据收集、使用、存储、共享和转移您的个人信息。



                  我们会收集或使用哪些信息
                  在您使用 Tell 的过程中，我们会按照下述的方式收集您在使用期间主动提供或因为使用服务而产生的信息，用于向您提供服务、优化服务以及保障您的信息安全：
                  在您注册 Tell 服务时，我们会收集您的基本信息，包括手机号码、电子邮箱、笔名、头像的信息，以帮助您完成注册，保护您的账号安全。手机号码属于敏感信息，收集此类信息是为了满足相关法律法规的网络实名制要求。若您不提供这类信息，您将无法正常使用我们的服务。
                  在您使用 Tell 服务期间，为保障您正常使用我们的服务，维护我们服务的正常运行，改进及优化我们的服务体验以及保障您的账号安全，我们会收集您的设备型号、操作系统、唯一设备标识符、登录 IP 地址、Tell 服务版本号、接入网络的方式、类型和状态、网络质量数据、设备加速器（如重力感应设备）、发表信息（如文字、图片、音频、视频）、身份信息（如申请篝火时需要提供身份证号码）、操作日志、服务日志信息等日志信息，这类信息是为提供服务必须收集的基础信息。
                  在您使用解忧馆功能时，您发布的咨询、解答、拥抱、感谢、书信等信息会存储在我们的服务器中，因为存储是实现这一功能所必需的。我们会以加密的方式存储。您可以通过联系客服来要求我们删除您创建的部分或全部内容，在此过程中，已经公开发布或投递给其他用户的部分可能无法完全删除，但我们会将无法删除的部分进行匿名化处理。
                  在您使用解忧馆中咨询、解答或使用信箱中的回信功能时，我们会根据您当前的 IP 地址推测您的所在城市，读取该城市当日天气并显示在信的结尾处。您可以在设置中允许我们读取您的精确地理位置，来获取更准确的天气信息。若您不希望提供精确地理位置，您可以在设置中关闭此选项，关闭后不会影响您的正常使用。
                  在您使用解忧馆中的解答功能时，您可以根据自己的偏好，来设定优先收取的咨询类型。在此期间，我们会收集这些信息，用于为您匹配合适的咨询供您收取。
                  在您使用小篝火的语音功能期间，我们会收集您的设备音频数据，因为收集数据是实现上述功能所必需的。在篝火活动结束后，这些数据会在服务器暂存备查，并在 15 个工作日内自动销毁。除非经您同意或遵从相关法律法规的要求，我们不会对外提供上述数据，或者将其用于该功能之外的其他用途。
  在您使用倾诉服务期间，您可以向其他用户支付倾诉费用。在收付款的过程中，我们可能会收集你提供的身份证号码、收款方式、第三方支付账号（包括支付宝账号、微信账号、Apple Pay 账号或其他形式的银行卡信息）以提供高效的交易服务。
  另外，根据相关法律法规及国家标准，以下情形中，我们可能会收集、使用您的相关个人信息且无需征求您的授权同意：
  - 与国家安全、国防安全等国家利益直接相关的；
  - 与公共安全、公共卫生、公众知情等重大公共利益直接相关的；
  - 与犯罪侦查、起诉、审判和判决执行等直接相关的；
  - 出于维护您或其他个人的生命、财产、声誉等重大合法权益但又很难得到本人同意的；
  - 所收集的个人信息是您自行向社会公众公开的；
  - 从合法公开披露的信息中收集个人信息的，如合法的新闻报道、政府信息公开等渠道；
  - 根据您要求签订和履行合同所必需的；
  - 用于维护所提供的产品或服务的安全稳定运行所必需的，例如发现、处置产品或服务的故障；
  - 为开展合法的新闻报道所必需的；
  - 出于公共利益开展统计或学术研究所必要，且其对外提供学术研究或描述的结果时，对结果中所包含的个人信息进行去标识化处理的；
  - 相关政府机关或其他法定授权组织所要求的；
  - 法律法规规定的其他情形。



  请您理解，我们向您提供的功能和服务是不断更新和发展的，如果某一功能或服务未在前述说明中且收集了您的信息，我们会通过页面提示、交互流程、网站公告等方式另行向您说明信息收集的内容、范围和目的，以征得您的同意。
  请您注意，目前 Tell 不会主动从第三方获取您的个人信息。如未来为业务发展需要从第三方间接获取您的个人信息，我们会在获取前向您明示您个人信息的来源、类型以及使用范围，如 Tell 开展业务需进行的个人信息处理活动超出您原本向第三方提供个人信息时的授权同意范围，我们将在处理您的该等个人信息前，征得您的明示同意；此外，我们也将会严格尊重相关法律法规的规定，并要求第三方保障其提供的信息的合法性。



  信息如何存储
  我们会按照法律法规的规定，将境内收集的用户个人信息存储于中国境内。
  一般而言，我们仅为实现目的所必需的时间保留您的个人信息。例如：
  手机号码：若您使用 Tell 服务，我们需要一直保存您的手机号码，以保证您正常使用该服务。当您注销 Tell 账号后，我们将删除相应的信息。
  咨询、解答及书信：当您在 Tell 服务中创建了咨询、解答及书信内容后，我们需要一直保存这些信息，以保证您正常使用解忧馆、信箱、查看解答与咨询历史等功能。目前我们不直接提供删除这些信息的功能，但您可通过产品内反馈、联系客服等方式联系我们要求删除。需要您特别注意的是：某些信息的删除会导致数据结构的破坏，为保障其他参与者的使用体验，我们保留这些信息，采用匿名化处理的方式来保护您的隐私。
  当我们的产品或服务发生停止运营的情形时，我们将以推送通知、公告等形式通知您，并在合理的期限内删除或匿名化处理您的个人信息。



  信息安全
  我们努力为用户的信息安全提供保障，以防止信息的丢失、不当使用、未经授权访问或披露。
  我们将在合理的安全水平内使用各种安全保护措施以保障信息的安全。例如，我们会使用加密技术（例如，SSL）、匿名化处理等手段来保护您的个人信息。
  我们将通过不断提升的技术手段保护您提供的个人信息，以防止您的个人信息被未经授权的软件泄露。例如，我们为了安全传输会在您设备本地完成部分信息加密的工作；为了预防病毒、木马程序或其他恶意程序、网站会获取您设备安装的应用信息或正在运行的进程信息。
  我们建立专门的管理制度、流程和组织以保障信息的安全。例如，我们严格限制访问信息的人员范围，要求他们遵守保密义务，并进行审查。
  若发生个人信息泄露等安全事件，我们会启动应急预案，阻止安全事件扩大，并以推送通知、公告等形式告知您。



  信息如何使用
  为了让您有更好的用户体验、改善我们的服务，在符合相关法律法规的前提下，我们可能将通过某些功能所收集的信息用于我们的其他服务。例如，我们可能将您在使用我们某一功能或服务时我们收集的信息，在另一功能或服务中用于向您提供特定内容，包括但不限于展示广告、对您浏览过的内容进行信息安全类提示、基于特征标签进行间接人群画像并提供更加精准和个性化的服务和内容等。
  为了确保服务的安全，帮助我们更好地了解我们应用程序的运行情况，我们可能记录相关信息，例如，您使用应用程序的频率、崩溃数据、总体使用情况、性能数据以及应用程序的来源。我们不会将我们存储在分析软件中的信息与您在应用程序中提供的任何个人身份信息相结合。
  如我们使用您的个人信息，超出了与收集时所声称的目的及具有直接或合理关联的范围，我们将在使用您的个人信息前，再次向您告知并征得您的明示同意。



  对外提供
  目前，我们不会主动共享或转让您的个人信息至第三方，如存在其他共享或转让您的个人信息或您需要我们将您的个人信息共享或转让至第三方情形时，我们会直接征得或确认第三方已征得您对上述行为的明示同意。
  我们不会对外公开披露其收集的个人信息。
  基于法律、法律程序、诉讼或政府主管部门强制性要求的情况下，我们可能会向有权机关披露您的个人信息。但我们保证，我们会要求披露请求方必须出具与之相应的有效法律文件。
  如存在其他需要公开披露的情形，我们会向您告知此次公开披露的目的、披露信息的类型及可能涉及的敏感信息，并征得您的明示同意。
  随着我们业务的持续发展，我们有可能进行合并、收购、资产转让等交易，当前述交易导致向第三方分享您的个人信息时，我们将通过公告、通知等形式告知您相关情形，按照法律法规及不低于本指引所要求的标准继续保护或要求新的控制者继续保护您的个人信息。
  另外，根据相关法律法规及国家标准，以下情形中，我们可能会共享、转让、公开披露个人信息无需事先征得个人信息主体的授权同意：
  - 与国家安全、国防安全直接相关的；
  - 与公共安全、公共卫生、重大公共利益直接相关的；
  - 与犯罪侦查、起诉、审判和判决执行等直接相关的；
  - 出于维护个人信息主体或其他个人的生命、财产等重大合法权益但又很难得到本人同意的；
  - 个人信息主体自行向社会公众公开的个人信息；
  - 从合法公开披露的信息中收集个人信息的，如合法的新闻报道、政府信息公开等渠道；
  - 法律法规规定的其他情形。



  您的权利
  我们非常重视您对个人信息的关注，并尽全力保护您对于自己个人信息访问、更正、删除以及撤回同意的权利，以使您拥有充分的能力保障您的隐私安全。您的权利包括：



  访问和更正您的个人信息

  您可以在设置-个人信息中访问和修改自己的头像、笔名、性别、生日。
  您可以在设置-账户安全中访问和修改自己的手机号码。
  您可以在设置-优先收取的咨询类别中访问、修改或删除自己对咨询类型的偏好。
  当您无法通过以上方式访问或自行更正时，您可以随时联系我们，我们将尽快回复您的请求。



  改变您授权同意的范围

  您可以在设置中开启或关闭「允许访问位置信息」选项，来改变您对访问地理位置的授权。



  删除您的个人信息

  由于 Tell 业务的特殊性，多数时候您产生的内容（如咨询、解答等）会在其他用户的界面中展示并保留。当您选择删除您产生的信息时，您无法删除已传递给其他用户的部分。您可以联系我们来协助删除这些信息，乃至删除您的账户。当您这么做时，您的部分或全部资料可能会保留在我们的服务器上，但我们会采用匿名化处理的方式来保障您的隐私。



  未成年人保护
  我们非常重视对未成年人个人信息的保护。根据相关法律法规的规定，若您是根据 Tell 用户协议具备使用资格的 18 周岁以下的未成年人，在使用 Tell 产品前，应事先取得您的家长或法定监护人的书面同意，否则不得创建自己的 Tell 账户。对于经家长或法定监护人同意而收集未成年个人信息的情况，我们只会在司法机关或行政机关要求、父母或监护人明确同意或者保护未成年人所必要的情况下使用或公开披露此信息。



  隐私政策的修订
  根据有关法律、法规及规范性文件的修订，或者因 Tell 发展需要，Tell 有权对本协议作出修改或变更，一旦本协议的内容发生变动，Tell 将会直接在 Tell 网站上公布修改之后的协议内容，并标明最后修订日期，该公布行为视为 Tell 已经通知用户修改内容。
  若变更导致减降用户在本协议下所享有的权利，我们会在相关服务的显著位置进行提示，或通过电子邮件、手机短信等形式向用户发送通知。
  如果用户不同意 Tell 对本协议所做的修改，用户有权并应当停止使用 Tell 提供的服务。若用户继续使用我们的服务，即表示同意受修订后的用户协议约束。



  联系方式
  如有任何疑问，您可通过发送邮件至 dz@tellers.cn 与我们的负责人联系。



  争议解决
  如果你认为我们的个人信息处理行为损害了你的合法权益，你可向有关政府部门反映。
  本隐私政策以及我们处理你个人信息事宜引起的争议，你还可以通过向深圳市福田法院提起诉讼的方式寻求解决。'''))))),
  );
}