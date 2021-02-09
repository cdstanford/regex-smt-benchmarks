;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^\(?(?<AreaCode>[2-9]\d{2})(\)?)(-|.|\s)?(?<Prefix>[1-9]\d{2})(-|.|\s)?(?<Suffix>\d{4})$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "(4599457785"
(define-fun Witness1 () String (seq.++ "(" (seq.++ "4" (seq.++ "5" (seq.++ "9" (seq.++ "9" (seq.++ "4" (seq.++ "5" (seq.++ "7" (seq.++ "7" (seq.++ "8" (seq.++ "5" ""))))))))))))
;witness2: "(980)3825081"
(define-fun Witness2 () String (seq.++ "(" (seq.++ "9" (seq.++ "8" (seq.++ "0" (seq.++ ")" (seq.++ "3" (seq.++ "8" (seq.++ "2" (seq.++ "5" (seq.++ "0" (seq.++ "8" (seq.++ "1" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.opt (re.range "(" "("))(re.++ (re.++ (re.range "2" "9") ((_ re.loop 2 2) (re.range "0" "9")))(re.++ (re.opt (re.range ")" ")"))(re.++ (re.opt (re.union (re.range "-" "-")(re.union (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))(re.++ (re.++ (re.range "1" "9") ((_ re.loop 2 2) (re.range "0" "9")))(re.++ (re.opt (re.union (re.range "-" "-")(re.union (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")) (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))))(re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
