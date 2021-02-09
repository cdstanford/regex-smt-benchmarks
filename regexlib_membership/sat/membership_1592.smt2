;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \d{1,3}.?\d{0,3}\s[a-zA-Z]{2,30}\s[a-zA-Z]{2,15}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "84\u00C77\xBSe OV"
(define-fun Witness1 () String (seq.++ "8" (seq.++ "4" (seq.++ "\xc7" (seq.++ "7" (seq.++ "\x0b" (seq.++ "S" (seq.++ "e" (seq.++ " " (seq.++ "O" (seq.++ "V" "")))))))))))
;witness2: "8\xB\u00A0PP\xCoNY\x1B\u008A\u00A6"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "\x0b" (seq.++ "\xa0" (seq.++ "P" (seq.++ "P" (seq.++ "\x0c" (seq.++ "o" (seq.++ "N" (seq.++ "Y" (seq.++ "\x1b" (seq.++ "\x8a" (seq.++ "\xa6" "")))))))))))))

(assert (= regexA (re.++ ((_ re.loop 1 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ ((_ re.loop 0 3) (re.range "0" "9"))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))(re.++ ((_ re.loop 2 30) (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))) ((_ re.loop 2 15) (re.union (re.range "A" "Z") (re.range "a" "z")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
