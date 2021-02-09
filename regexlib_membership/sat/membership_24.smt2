;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([3]{1}[0-1]{1}|[1-1]?[0-9]{1})-([0-1]?[0-2]{1}|[0-9]{1})-[0-9]{4}([\s]+([2]{1}[0-3]{1}|[0-1]?[0-9]{1})[:]{1}([0-5]?[0-9]{1})([:]{1}([0-5]?[0-9]{1}))?)?$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "10-9-3928"
(define-fun Witness1 () String (seq.++ "1" (seq.++ "0" (seq.++ "-" (seq.++ "9" (seq.++ "-" (seq.++ "3" (seq.++ "9" (seq.++ "2" (seq.++ "8" ""))))))))))
;witness2: "8-1-8675"
(define-fun Witness2 () String (seq.++ "8" (seq.++ "-" (seq.++ "1" (seq.++ "-" (seq.++ "8" (seq.++ "6" (seq.++ "7" (seq.++ "5" "")))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.union (re.++ (re.range "3" "3") (re.range "0" "1")) (re.++ (re.opt (re.range "1" "1")) (re.range "0" "9")))(re.++ (re.range "-" "-")(re.++ (re.union (re.++ (re.opt (re.range "0" "1")) (re.range "0" "2")) (re.range "0" "9"))(re.++ (re.range "-" "-")(re.++ ((_ re.loop 4 4) (re.range "0" "9"))(re.++ (re.opt (re.++ (re.+ (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0")))))(re.++ (re.union (re.++ (re.range "2" "2") (re.range "0" "3")) (re.++ (re.opt (re.range "0" "1")) (re.range "0" "9")))(re.++ (re.range ":" ":")(re.++ (re.++ (re.opt (re.range "0" "5")) (re.range "0" "9")) (re.opt (re.++ (re.range ":" ":") (re.++ (re.opt (re.range "0" "5")) (re.range "0" "9"))))))))) (str.to_re ""))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
