;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^([a-zA-Z]+(.)?[\s]*)$
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "Z\u00FD\u0085\xC"
(define-fun Witness1 () String (seq.++ "Z" (seq.++ "\xfd" (seq.++ "\x85" (seq.++ "\x0c" "")))))
;witness2: "GZGkaZ\u00AF"
(define-fun Witness2 () String (seq.++ "G" (seq.++ "Z" (seq.++ "G" (seq.++ "k" (seq.++ "a" (seq.++ "Z" (seq.++ "\xaf" ""))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (re.++ (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))(re.++ (re.opt (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))) (re.* (re.union (re.range "\x09" "\x0d")(re.union (re.range " " " ")(re.union (re.range "\x85" "\x85") (re.range "\xa0" "\xa0"))))))) (str.to_re "")))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
