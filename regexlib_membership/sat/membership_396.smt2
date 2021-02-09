;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^[a-zA-Z0-9]+[\s]*[a-zA-Z0-9.\-\,\#]+[\s]*[a-zA-Z0-9.\-\,\#]+[a-zA-Z0-9\s.\-\,\#]*$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Y\x9.K\u00A0q\u0085X"
(define-fun Witness1 () String (seq.++ "Y" (seq.++ "\x09" (seq.++ "." (seq.++ "K" (seq.++ "\xa0" (seq.++ "q" (seq.++ "\x85" (seq.++ "X" "")))))))))
;witness2: "t8.qa19\u00A0"
(define-fun Witness2 () String (seq.++ "t" (seq.++ "8" (seq.++ "." (seq.++ "q" (seq.++ "a" (seq.++ "1" (seq.++ "9" (seq.++ "\xa0" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.+ (re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.+ (re.union (re.range "#" "#")(re.union (re.range "," ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.+ (re.union (re.range "#" "#")(re.union (re.range "," ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z") (re.range "a" "z"))))))(re.++ (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "#" "#")(re.union (re.range "," ".")(re.union (re.range "0" "9")(re.union (re.range "A" "Z")(re.union (re.range "a" "z")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
