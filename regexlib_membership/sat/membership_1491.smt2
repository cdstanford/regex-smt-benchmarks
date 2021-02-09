;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([A-HK-PRSVWY][A-HJ-PR-Y])\s?([0][2-9]|[1-9][0-9])\s?[A-HJ-PR-Z]{3}$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "LY87\xDZEZ"
(define-fun Witness1 () String (seq.++ "L" (seq.++ "Y" (seq.++ "8" (seq.++ "7" (seq.++ "\x0d" (seq.++ "Z" (seq.++ "E" (seq.++ "Z" "")))))))))
;witness2: "YY\u00A008 PKT"
(define-fun Witness2 () String (seq.++ "Y" (seq.++ "Y" (seq.++ "\xa0" (seq.++ "0" (seq.++ "8" (seq.++ " " (seq.++ "P" (seq.++ "K" (seq.++ "T" ""))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.union (re.range "A" "H")(re.union (re.range "K" "P")(re.union (re.range "R" "S")(re.union (re.range "V" "W") (re.range "Y" "Y"))))) (re.union (re.range "A" "H")(re.union (re.range "J" "P") (re.range "R" "Y"))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (re.++ (re.range "0" "0") (re.range "2" "9")) (re.++ (re.range "1" "9") (re.range "0" "9")))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 3 3) (re.union (re.range "A" "H")(re.union (re.range "J" "P") (re.range "R" "Z")))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
