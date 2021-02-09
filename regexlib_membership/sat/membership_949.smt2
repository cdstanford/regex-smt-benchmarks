;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([0-1]?\d|2[0-3])([:]?[0-5]\d)?([:]?|[0-5]\d)?\s?(A|AM|P|p|a|PM|am|pm|pM|aM|Am|Pm)?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "2151\u00A0pm"
(define-fun Witness1 () String (seq.++ "2" (seq.++ "1" (seq.++ "5" (seq.++ "1" (seq.++ "\xa0" (seq.++ "p" (seq.++ "m" ""))))))))
;witness2: "5:"
(define-fun Witness2 () String (seq.++ "5" (seq.++ ":" "")))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.opt (re.range "0" "1")) (re.range "0" "9")) (re.++ (re.range "2" "2") (re.range "0" "3")))(re.++ (re.opt (re.++ (re.opt (re.range ":" ":"))(re.++ (re.range "0" "5") (re.range "0" "9"))))(re.++ (re.opt (re.union (re.opt (re.range ":" ":")) (re.++ (re.range "0" "5") (re.range "0" "9"))))(re.++ (re.opt (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.opt (re.union (re.range "A" "A")(re.union (str.to_re (seq.++ "A" (seq.++ "M" "")))(re.union (re.union (re.range "P" "P")(re.union (re.range "a" "a") (re.range "p" "p")))(re.union (str.to_re (seq.++ "P" (seq.++ "M" "")))(re.union (str.to_re (seq.++ "a" (seq.++ "m" "")))(re.union (str.to_re (seq.++ "p" (seq.++ "m" "")))(re.union (str.to_re (seq.++ "p" (seq.++ "M" "")))(re.union (str.to_re (seq.++ "a" (seq.++ "M" "")))(re.union (str.to_re (seq.++ "A" (seq.++ "m" ""))) (str.to_re (seq.++ "P" (seq.++ "m" ""))))))))))))) (str.to_re "")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
