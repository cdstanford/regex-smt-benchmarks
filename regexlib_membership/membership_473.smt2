;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(Randal (?:L\.)? Schwartz|merlyn)$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Randal L. Schwartz"
(define-fun Witness1 () String (str.++ "R" (str.++ "a" (str.++ "n" (str.++ "d" (str.++ "a" (str.++ "l" (str.++ " " (str.++ "L" (str.++ "." (str.++ " " (str.++ "S" (str.++ "c" (str.++ "h" (str.++ "w" (str.++ "a" (str.++ "r" (str.++ "t" (str.++ "z" "")))))))))))))))))))
;witness2: "Randal  Schwartz"
(define-fun Witness2 () String (str.++ "R" (str.++ "a" (str.++ "n" (str.++ "d" (str.++ "a" (str.++ "l" (str.++ " " (str.++ " " (str.++ "S" (str.++ "c" (str.++ "h" (str.++ "w" (str.++ "a" (str.++ "r" (str.++ "t" (str.++ "z" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (str.to_re (str.++ "R" (str.++ "a" (str.++ "n" (str.++ "d" (str.++ "a" (str.++ "l" (str.++ " " ""))))))))(re.++ (re.opt (str.to_re (str.++ "L" (str.++ "." "")))) (str.to_re (str.++ " " (str.++ "S" (str.++ "c" (str.++ "h" (str.++ "w" (str.++ "a" (str.++ "r" (str.++ "t" (str.++ "z" "")))))))))))) (str.to_re (str.++ "m" (str.++ "e" (str.++ "r" (str.++ "l" (str.++ "y" (str.++ "n" "")))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
