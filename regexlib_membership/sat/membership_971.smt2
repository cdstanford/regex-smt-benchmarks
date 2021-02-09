;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^(([1-9]?\d|1\d\d|2[0-4]\d|25[0-5]).){3}([1-9]?\d|1\d\d|2[0-4]\d|25[0-5])$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "93t0\x9248\xC255"
(define-fun Witness1 () String (seq.++ "9" (seq.++ "3" (seq.++ "t" (seq.++ "0" (seq.++ "\x09" (seq.++ "2" (seq.++ "4" (seq.++ "8" (seq.++ "\x0c" (seq.++ "2" (seq.++ "5" (seq.++ "5" "")))))))))))))
;witness2: "249\"5-42\xE168"
(define-fun Witness2 () String (seq.++ "2" (seq.++ "4" (seq.++ "9" (seq.++ "\x22" (seq.++ "5" (seq.++ "-" (seq.++ "4" (seq.++ "2" (seq.++ "\x0e" (seq.++ "1" (seq.++ "6" (seq.++ "8" "")))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ ((_ re.loop 3 3) (re.++ (re.union (re.++ (re.opt (re.range "1" "9")) (re.range "0" "9"))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "0" "9") (re.range "0" "9")))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))))) (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))))(re.++ (re.union (re.++ (re.opt (re.range "1" "9")) (re.range "0" "9"))(re.union (re.++ (re.range "1" "1")(re.++ (re.range "0" "9") (re.range "0" "9")))(re.union (re.++ (re.range "2" "2")(re.++ (re.range "0" "4") (re.range "0" "9"))) (re.++ (str.to_re (seq.++ "2" (seq.++ "5" ""))) (re.range "0" "5"))))) (str.to_re ""))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
