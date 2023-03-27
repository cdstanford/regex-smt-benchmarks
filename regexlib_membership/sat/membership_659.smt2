;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-G](b|#)?((m(aj)?|M|aug|dim|sus)([2-7]|9|13)?)?(\/[A-G](b|#)?)?$
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "Gbdim13/F"
(define-fun Witness1 () String (str.++ "G" (str.++ "b" (str.++ "d" (str.++ "i" (str.++ "m" (str.++ "1" (str.++ "3" (str.++ "/" (str.++ "F" ""))))))))))
;witness2: "Ebaug9/C#"
(define-fun Witness2 () String (str.++ "E" (str.++ "b" (str.++ "a" (str.++ "u" (str.++ "g" (str.++ "9" (str.++ "/" (str.++ "C" (str.++ "#" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "A" "G")(re.++ (re.opt (re.union (re.range "#" "#") (re.range "b" "b")))(re.++ (re.opt (re.++ (re.union (re.++ (re.range "m" "m") (re.opt (str.to_re (str.++ "a" (str.++ "j" "")))))(re.union (re.range "M" "M")(re.union (str.to_re (str.++ "a" (str.++ "u" (str.++ "g" ""))))(re.union (str.to_re (str.++ "d" (str.++ "i" (str.++ "m" "")))) (str.to_re (str.++ "s" (str.++ "u" (str.++ "s" "")))))))) (re.opt (re.union (re.union (re.range "2" "7") (re.range "9" "9")) (str.to_re (str.++ "1" (str.++ "3" "")))))))(re.++ (re.opt (re.++ (re.range "/" "/")(re.++ (re.range "A" "G") (re.opt (re.union (re.range "#" "#") (re.range "b" "b")))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
