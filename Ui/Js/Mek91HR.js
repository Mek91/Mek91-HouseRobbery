/////////////////////////////////////////////////////////////////////
const PlayerSpeed = document.getElementById("PlayerSpeed");
const PlayerSpeedIn = document.getElementById("PlayerSpeedIn");
const PlayerSpeedText = document.getElementById("Text");
const SoundLevel = document.getElementById("SoundLevel");
/////////////////////////////////////////////////////////////////////
const SelectedYesOrNo = document.getElementById("SelectedYesOrNo");
const Surrounded = document.getElementById("Surrounded");
const Yes = document.getElementById("Yes");
const Or = document.getElementById("Or");
const No = document.getElementById("No");
/////////////////////////////////////////////////////////////////////
window.addEventListener("message", (event) => 
{
    const data = event.data;
    const Action = data.action;

    if (Action == "Mek91HR_Open") 
    {
        return Mek91HR_Open(data.data);
    }
    else if (Action == "Mek91HR_AllHide") 
    {
        return Mek91HR_AllHide();
    }
    else if (Action == "Mek91HR_PlayerSpeedHide")
    {
        return Mek91HR_PlayerSpeedHide();
    }
    else 
    {
        return;
    }
});
/////////////////////////////////////////////////////////////////////
const Mek91HR_Open = (Mek91HR) =>
{
    if (Mek91HR == null || Mek91HR == "") 
    {
        console.log("No data detected");
        return null;
    }

    if (Mek91HR.Open == "PlayerSpeed")
    {
        PlayerSpeedIn.classList.remove("PlayerSpeedInDeActive");
        PlayerSpeedIn.classList.add("PlayerSpeedInActive");

        PlayerSpeedText.textContent = Mek91HR.PlayerSpeedText;
        SoundLevel.textContent = Mek91HR.SoundLevel;
        SoundLevel.style.color = "rgb(" + Mek91HR.R + ", " + Mek91HR.G + ", " + Mek91HR.B + ")";

        ShowOrHide(PlayerSpeed, "Show");
    }

    if(Mek91HR.Open == "YesOrNo")
    {
        ShowOrHide(PlayerSpeed, "Hide");

        Surrounded.textContent = Mek91HR.Surrounded;
        Yes.textContent = Mek91HR.Yes;
        Or.textContent = Mek91HR.Or;
        No.textContent = Mek91HR.No;

        ShowOrHide(SelectedYesOrNo, "Show");
    }
}

const Mek91HR_AllHide = () =>
{
    ShowOrHide(PlayerSpeed, "Hide");
    ShowOrHide(SelectedYesOrNo, "Hide");
}

const Mek91HR_PlayerSpeedHide = () => 
{
    PlayerSpeedIn.classList.remove("PlayerSpeedInActive");
    PlayerSpeedIn.classList.add("PlayerSpeedInDeActive");
}
/////////////////////////////////////////////////////////////////////
Yes.addEventListener("click", function() {
    const dataToSend = {
        Result: "Yes"
    };
    fetch('https://Mek91-HouseRobbery/Mek91-HR:Ui:SelectYesOrNo', {
        method: 'post',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(dataToSend),
    });
});

No.addEventListener("click", function() {
    const dataToSend = {
        Result: "No"
    };
    fetch('https://Mek91-HouseRobbery/Mek91-HR:Ui:SelectYesOrNo', {
        method: 'post',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify(dataToSend),
    });
});
/////////////////////////////////////////////////////////////////////
function ShowOrHide(Id, ShowOrHide) 
{
    if (ShowOrHide == "Show") 
    {
        Id.style.display = "flex";
    }
    else if(ShowOrHide == "Hide")
    {
        Id.style.display = "none";
    }
}
/////////////////////////////////////////////////////////////////////