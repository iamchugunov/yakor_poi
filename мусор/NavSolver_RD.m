function [UserPos,nev] = NavSolver_RD(SatPos, RD, InitPos, h)
MaxErr = 1e-3;
MaxIter = 10;
stopflag = 1;
k=0;
UserPos = InitPos;
N = length(InitPos);
rho = zeros(length(RD),1);
H = zeros(length(RD),N);
Niter = 0;
while stopflag
k=k+1;
Niter = Niter + 1;
for m = 1:length(RD)
        rm = sqrt((SatPos(1,1) - UserPos(1,1))^2 + (SatPos(2,1) - UserPos(2,1))^2 + (SatPos(3,1) - h)^2);
        ri = sqrt((SatPos(1,m+1) - UserPos(1,1))^2 + (SatPos(2,m+1) - UserPos(2,1))^2 + (SatPos(3,m+1) - h)^2);
        rho(m) = -rm + ri;
    for n = 1:N
        H(m,n) = (SatPos(n,1)-UserPos(n))/rm -(SatPos(n,m+1)-UserPos(n))/ri;
    end
end
    DU=UserPos; %���������� ��� ������� ��������
    dPR=RD-rho; %������� �� ����������
    UserPos=UserPos+((H'*H)^(-1))*H'*dPR; %��������� �������� �������
    nev = norm(dPR);
    dX=UserPos-DU; %���������� ������
    DOP=sqrt(trace((H'*H)^(-1))); %�������������� ������
    %�������� ��������
    if norm(dX)<=MaxErr
        stopflag=0; %����� �� �����, ���� ���������� ��������� ��������
    elseif Niter>=MaxIter
            stopflag=0; %����� �� �����, ���� ���������� ���������� ����� ��������
    end
    end
end

