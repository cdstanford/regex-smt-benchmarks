;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = (\[url=?"?)([^\]"]*)("?\])([^\[]*)(\[/url\])
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "[url\"]\x14\u00A8[/url]"
(define-fun Witness1 () String (seq.++ "[" (seq.++ "u" (seq.++ "r" (seq.++ "l" (seq.++ "\x22" (seq.++ "]" (seq.++ "\x14" (seq.++ "\xa8" (seq.++ "[" (seq.++ "/" (seq.++ "u" (seq.++ "r" (seq.++ "l" (seq.++ "]" "")))))))))))))))
;witness2: "cp[url\"][/url]"
(define-fun Witness2 () String (seq.++ "c" (seq.++ "p" (seq.++ "[" (seq.++ "u" (seq.++ "r" (seq.++ "l" (seq.++ "\x22" (seq.++ "]" (seq.++ "[" (seq.++ "/" (seq.++ "u" (seq.++ "r" (seq.++ "l" (seq.++ "]" "")))))))))))))))

(assert (= regexA (re.++ (re.++ (str.to_re (seq.++ "[" (seq.++ "u" (seq.++ "r" (seq.++ "l" "")))))(re.++ (re.opt (re.range "=" "=")) (re.opt (re.range "\x22" "\x22"))))(re.++ (re.* (re.union (re.range "\x00" "!")(re.union (re.range "#" "\x5c") (re.range "^" "\xff"))))(re.++ (re.++ (re.opt (re.range "\x22" "\x22")) (re.range "]" "]"))(re.++ (re.* (re.union (re.range "\x00" "Z") (re.range "\x5c" "\xff"))) (str.to_re (seq.++ "[" (seq.++ "/" (seq.++ "u" (seq.++ "r" (seq.++ "l" (seq.++ "]" "")))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
