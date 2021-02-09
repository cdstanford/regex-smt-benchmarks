;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(?<CountryCode>[1]?)\s?\(?(?<AreaCode>[2-9]{1}\d{2})\)?\s?(?<Prefix>[0-9]{3})(?:[-]|\s)?(?<Postfix>\d{4})\s?(?:ext|x\s?)(?<Extension>[1-9]{1}\d*)?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "1(611\x99756898x "
(define-fun Witness1 () String (seq.++ "1" (seq.++ "(" (seq.++ "6" (seq.++ "1" (seq.++ "1" (seq.++ "\x09" (seq.++ "9" (seq.++ "7" (seq.++ "5" (seq.++ "6" (seq.++ "8" (seq.++ "9" (seq.++ "8" (seq.++ "x" (seq.++ " " ""))))))))))))))))
;witness2: "\x9989 357\u00852138x\u00A0"
(define-fun Witness2 () String (seq.++ "\x09" (seq.++ "9" (seq.++ "8" (seq.++ "9" (seq.++ " " (seq.++ "3" (seq.++ "5" (seq.++ "7" (seq.++ "\x85" (seq.++ "2" (seq.++ "1" (seq.++ "3" (seq.++ "8" (seq.++ "x" (seq.++ "\xa0" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "1" "1"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.range "(" "("))(re.++ (re.++ (re.range "2" "9") ((_ re.loop 2 2) (re.range "0" "9")))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ ((_ re.loop 3 3) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "-" "-")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (str.to_re (seq.++ "e" (seq.++ "x" (seq.++ "t" "")))) (re.++ (re.range "x" "x") (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))(re.++ (re.opt (re.++ (re.range "1" "9") (re.* (re.range "0" "9")))) (str.to_re ""))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
