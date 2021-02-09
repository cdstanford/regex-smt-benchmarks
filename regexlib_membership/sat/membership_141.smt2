;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^http://\\.?video\\.google+\\.\\w{2,3}/videoplay\\?docid=[\\w-]{19}
;---
(set-info :status sat)
(set-option :print-success true)
(set-logic QF_BVRE)

(declare-const regexA (RegEx String))
(declare-const x String)

;witness1: "http://\Nvideo\\u00C4googleee\\x14\www/videoplaydocid=w--\-\-w--w\w--\-\w"
(define-fun Witness1 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "\x5c" (seq.++ "N" (seq.++ "v" (seq.++ "i" (seq.++ "d" (seq.++ "e" (seq.++ "o" (seq.++ "\x5c" (seq.++ "\xc4" (seq.++ "g" (seq.++ "o" (seq.++ "o" (seq.++ "g" (seq.++ "l" (seq.++ "e" (seq.++ "e" (seq.++ "e" (seq.++ "\x5c" (seq.++ "\x14" (seq.++ "\x5c" (seq.++ "w" (seq.++ "w" (seq.++ "w" (seq.++ "/" (seq.++ "v" (seq.++ "i" (seq.++ "d" (seq.++ "e" (seq.++ "o" (seq.++ "p" (seq.++ "l" (seq.++ "a" (seq.++ "y" (seq.++ "d" (seq.++ "o" (seq.++ "c" (seq.++ "i" (seq.++ "d" (seq.++ "=" (seq.++ "w" (seq.++ "-" (seq.++ "-" (seq.++ "\x5c" (seq.++ "-" (seq.++ "\x5c" (seq.++ "-" (seq.++ "w" (seq.++ "-" (seq.++ "-" (seq.++ "w" (seq.++ "\x5c" (seq.++ "w" (seq.++ "-" (seq.++ "-" (seq.++ "\x5c" (seq.++ "-" (seq.++ "\x5c" (seq.++ "w" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "http://\video\^google\\x1C\ww/videoplay\docid=-w--\w--w-w----\-w\"
(define-fun Witness2 () String (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "\x5c" (seq.++ "v" (seq.++ "i" (seq.++ "d" (seq.++ "e" (seq.++ "o" (seq.++ "\x5c" (seq.++ "^" (seq.++ "g" (seq.++ "o" (seq.++ "o" (seq.++ "g" (seq.++ "l" (seq.++ "e" (seq.++ "\x5c" (seq.++ "\x1c" (seq.++ "\x5c" (seq.++ "w" (seq.++ "w" (seq.++ "/" (seq.++ "v" (seq.++ "i" (seq.++ "d" (seq.++ "e" (seq.++ "o" (seq.++ "p" (seq.++ "l" (seq.++ "a" (seq.++ "y" (seq.++ "\x5c" (seq.++ "d" (seq.++ "o" (seq.++ "c" (seq.++ "i" (seq.++ "d" (seq.++ "=" (seq.++ "-" (seq.++ "w" (seq.++ "-" (seq.++ "-" (seq.++ "\x5c" (seq.++ "w" (seq.++ "-" (seq.++ "-" (seq.++ "w" (seq.++ "-" (seq.++ "w" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "-" (seq.++ "\x5c" (seq.++ "-" (seq.++ "w" (seq.++ "\x5c" "")))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (seq.++ "h" (seq.++ "t" (seq.++ "t" (seq.++ "p" (seq.++ ":" (seq.++ "/" (seq.++ "/" (seq.++ "\x5c" "")))))))))(re.++ (re.opt (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff")))(re.++ (str.to_re (seq.++ "v" (seq.++ "i" (seq.++ "d" (seq.++ "e" (seq.++ "o" (seq.++ "\x5c" "")))))))(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (str.to_re (seq.++ "g" (seq.++ "o" (seq.++ "o" (seq.++ "g" (seq.++ "l" ""))))))(re.++ (re.+ (re.range "e" "e"))(re.++ (re.range "\x5c" "\x5c")(re.++ (re.union (re.range "\x00" "\x09") (re.range "\x0b" "\xff"))(re.++ (re.range "\x5c" "\x5c")(re.++ ((_ re.loop 2 3) (re.range "w" "w"))(re.++ (str.to_re (seq.++ "/" (seq.++ "v" (seq.++ "i" (seq.++ "d" (seq.++ "e" (seq.++ "o" (seq.++ "p" (seq.++ "l" (seq.++ "a" (seq.++ "y" "")))))))))))(re.++ (re.opt (re.range "\x5c" "\x5c"))(re.++ (str.to_re (seq.++ "d" (seq.++ "o" (seq.++ "c" (seq.++ "i" (seq.++ "d" (seq.++ "=" ""))))))) ((_ re.loop 19 19) (re.union (re.range "-" "-")(re.union (re.range "\x5c" "\x5c") (re.range "w" "w"))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
