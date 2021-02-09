;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = \\s\\d{2}[-]\\w{3}-\\d{4}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "\s\dd-\www-\ddddX"
(define-fun Witness1 () String (seq.++ "\x5c" (seq.++ "s" (seq.++ "\x5c" (seq.++ "d" (seq.++ "d" (seq.++ "-" (seq.++ "\x5c" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "-" (seq.++ "\x5c" (seq.++ "d" (seq.++ "d" (seq.++ "d" (seq.++ "d" (seq.++ "X" ""))))))))))))))))))
;witness2: "\u00E3\s\dd-\www-\dddd\u00EA\u00CD\u00D2"
(define-fun Witness2 () String (seq.++ "\xe3" (seq.++ "\x5c" (seq.++ "s" (seq.++ "\x5c" (seq.++ "d" (seq.++ "d" (seq.++ "-" (seq.++ "\x5c" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "-" (seq.++ "\x5c" (seq.++ "d" (seq.++ "d" (seq.++ "d" (seq.++ "d" (seq.++ "\xea" (seq.++ "\xcd" (seq.++ "\xd2" "")))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "\x5c" (seq.++ "s" (seq.++ "\x5c" ""))))(re.++ ((_ re.loop 2 2) (re.range "d" "d"))(re.++ (str.to_re (seq.++ "-" (seq.++ "\x5c" "")))(re.++ ((_ re.loop 3 3) (re.range "w" "w"))(re.++ (str.to_re (seq.++ "-" (seq.++ "\x5c" ""))) ((_ re.loop 4 4) (re.range "d" "d")))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
