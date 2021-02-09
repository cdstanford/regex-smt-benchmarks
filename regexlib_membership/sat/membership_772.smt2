;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = <img[^>]*src=\"?([^\"]*)\"?([^>]*alt=\"?([^\"]*)\"?)?[^>]*>
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "4n<imgsrc=H\u0081\"alt=qP\u00ED\">%G"
(define-fun Witness1 () String (seq.++ "4" (seq.++ "n" (seq.++ "<" (seq.++ "i" (seq.++ "m" (seq.++ "g" (seq.++ "s" (seq.++ "r" (seq.++ "c" (seq.++ "=" (seq.++ "H" (seq.++ "\x81" (seq.++ "\x22" (seq.++ "a" (seq.++ "l" (seq.++ "t" (seq.++ "=" (seq.++ "q" (seq.++ "P" (seq.++ "\xed" (seq.++ "\x22" (seq.++ ">" (seq.++ "%" (seq.++ "G" "")))))))))))))))))))))))))
;witness2: "<imgsrc=\"\u0085\u009FW\"\u008B>"
(define-fun Witness2 () String (seq.++ "<" (seq.++ "i" (seq.++ "m" (seq.++ "g" (seq.++ "s" (seq.++ "r" (seq.++ "c" (seq.++ "=" (seq.++ "\x22" (seq.++ "\x85" (seq.++ "\x9f" (seq.++ "W" (seq.++ "\x22" (seq.++ "\x8b" (seq.++ ">" ""))))))))))))))))

(assert (= regexA (re.++ (str.to_re (seq.++ "<" (seq.++ "i" (seq.++ "m" (seq.++ "g" "")))))(re.++ (re.* (re.union (re.range "\x00" "=") (re.range "?" "\xff")))(re.++ (str.to_re (seq.++ "s" (seq.++ "r" (seq.++ "c" (seq.++ "=" "")))))(re.++ (re.opt (re.range "\x22" "\x22"))(re.++ (re.* (re.union (re.range "\x00" "!") (re.range "#" "\xff")))(re.++ (re.opt (re.range "\x22" "\x22"))(re.++ (re.opt (re.++ (re.* (re.union (re.range "\x00" "=") (re.range "?" "\xff")))(re.++ (str.to_re (seq.++ "a" (seq.++ "l" (seq.++ "t" (seq.++ "=" "")))))(re.++ (re.opt (re.range "\x22" "\x22"))(re.++ (re.* (re.union (re.range "\x00" "!") (re.range "#" "\xff"))) (re.opt (re.range "\x22" "\x22")))))))(re.++ (re.* (re.union (re.range "\x00" "=") (re.range "?" "\xff"))) (re.range ">" ">")))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
