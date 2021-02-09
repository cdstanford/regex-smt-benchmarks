;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[A-G](b|#)?((m(aj)?|M|aug|dim|sus)([2-7]|9|13)?)?(\/[A-G](b|#)?)?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Gbdim13/F"
(define-fun Witness1 () String (seq.++ "G" (seq.++ "b" (seq.++ "d" (seq.++ "i" (seq.++ "m" (seq.++ "1" (seq.++ "3" (seq.++ "/" (seq.++ "F" ""))))))))))
;witness2: "Ebaug9/C#"
(define-fun Witness2 () String (seq.++ "E" (seq.++ "b" (seq.++ "a" (seq.++ "u" (seq.++ "g" (seq.++ "9" (seq.++ "/" (seq.++ "C" (seq.++ "#" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.range "A" "G")(re.++ (re.opt (re.union (re.range "#" "#") (re.range "b" "b")))(re.++ (re.opt (re.++ (re.union (re.++ (re.range "m" "m") (re.opt (str.to_re (seq.++ "a" (seq.++ "j" "")))))(re.union (re.range "M" "M")(re.union (str.to_re (seq.++ "a" (seq.++ "u" (seq.++ "g" ""))))(re.union (str.to_re (seq.++ "d" (seq.++ "i" (seq.++ "m" "")))) (str.to_re (seq.++ "s" (seq.++ "u" (seq.++ "s" "")))))))) (re.opt (re.union (re.union (re.range "2" "7") (re.range "9" "9")) (str.to_re (seq.++ "1" (seq.++ "3" "")))))))(re.++ (re.opt (re.++ (re.range "/" "/")(re.++ (re.range "A" "G") (re.opt (re.union (re.range "#" "#") (re.range "b" "b")))))) (str.to_re ""))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
