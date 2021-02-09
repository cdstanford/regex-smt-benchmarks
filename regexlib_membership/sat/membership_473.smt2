;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(Randal (?:L\.)? Schwartz|merlyn)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Randal L. Schwartz"
(define-fun Witness1 () String (seq.++ "R" (seq.++ "a" (seq.++ "n" (seq.++ "d" (seq.++ "a" (seq.++ "l" (seq.++ " " (seq.++ "L" (seq.++ "." (seq.++ " " (seq.++ "S" (seq.++ "c" (seq.++ "h" (seq.++ "w" (seq.++ "a" (seq.++ "r" (seq.++ "t" (seq.++ "z" "")))))))))))))))))))
;witness2: "Randal  Schwartz"
(define-fun Witness2 () String (seq.++ "R" (seq.++ "a" (seq.++ "n" (seq.++ "d" (seq.++ "a" (seq.++ "l" (seq.++ " " (seq.++ " " (seq.++ "S" (seq.++ "c" (seq.++ "h" (seq.++ "w" (seq.++ "a" (seq.++ "r" (seq.++ "t" (seq.++ "z" "")))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (str.to_re (seq.++ "R" (seq.++ "a" (seq.++ "n" (seq.++ "d" (seq.++ "a" (seq.++ "l" (seq.++ " " ""))))))))(re.++ (re.opt (str.to_re (seq.++ "L" (seq.++ "." "")))) (str.to_re (seq.++ " " (seq.++ "S" (seq.++ "c" (seq.++ "h" (seq.++ "w" (seq.++ "a" (seq.++ "r" (seq.++ "t" (seq.++ "z" "")))))))))))) (str.to_re (seq.++ "m" (seq.++ "e" (seq.++ "r" (seq.++ "l" (seq.++ "y" (seq.++ "n" "")))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
