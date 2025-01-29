SELECT Prevision.*, 
    printf("%.3f", State.HDI) AS StateHDI, 
    printf("%.2f", State.Income) AS StateIncome
  FROM Prevision
  INNER JOIN State ON Prevision.State = State.ID;
DROP TABLE Prevision;