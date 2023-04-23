;---
; using 8-bit bit-vectors as characters
; check membership of .Net regex
; regexA = ^http://\\.?video\\.google+\\.\\w{2,3}/videoplay\\?docid=[\\w-]{19}
;---
;(set-info :status sat)
;(set-option :print-success true)
(set-logic QF_S)

(declare-const regexA RegLan)
(declare-const x String)

;witness1: "http://\Nvideo\\u00C4googleee\\x14\www/videoplaydocid=w--\-\-w--w\w--\-\w"
(define-fun Witness1 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "\u{5c}" (str.++ "N" (str.++ "v" (str.++ "i" (str.++ "d" (str.++ "e" (str.++ "o" (str.++ "\u{5c}" (str.++ "\u{c4}" (str.++ "g" (str.++ "o" (str.++ "o" (str.++ "g" (str.++ "l" (str.++ "e" (str.++ "e" (str.++ "e" (str.++ "\u{5c}" (str.++ "\u{14}" (str.++ "\u{5c}" (str.++ "w" (str.++ "w" (str.++ "w" (str.++ "/" (str.++ "v" (str.++ "i" (str.++ "d" (str.++ "e" (str.++ "o" (str.++ "p" (str.++ "l" (str.++ "a" (str.++ "y" (str.++ "d" (str.++ "o" (str.++ "c" (str.++ "i" (str.++ "d" (str.++ "=" (str.++ "w" (str.++ "-" (str.++ "-" (str.++ "\u{5c}" (str.++ "-" (str.++ "\u{5c}" (str.++ "-" (str.++ "w" (str.++ "-" (str.++ "-" (str.++ "w" (str.++ "\u{5c}" (str.++ "w" (str.++ "-" (str.++ "-" (str.++ "\u{5c}" (str.++ "-" (str.++ "\u{5c}" (str.++ "w" ""))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))
;witness2: "http://\video\^google\\x1C\ww/videoplay\docid=-w--\w--w-w----\-w\"
(define-fun Witness2 () String (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "\u{5c}" (str.++ "v" (str.++ "i" (str.++ "d" (str.++ "e" (str.++ "o" (str.++ "\u{5c}" (str.++ "^" (str.++ "g" (str.++ "o" (str.++ "o" (str.++ "g" (str.++ "l" (str.++ "e" (str.++ "\u{5c}" (str.++ "\u{1c}" (str.++ "\u{5c}" (str.++ "w" (str.++ "w" (str.++ "/" (str.++ "v" (str.++ "i" (str.++ "d" (str.++ "e" (str.++ "o" (str.++ "p" (str.++ "l" (str.++ "a" (str.++ "y" (str.++ "\u{5c}" (str.++ "d" (str.++ "o" (str.++ "c" (str.++ "i" (str.++ "d" (str.++ "=" (str.++ "-" (str.++ "w" (str.++ "-" (str.++ "-" (str.++ "\u{5c}" (str.++ "w" (str.++ "-" (str.++ "-" (str.++ "w" (str.++ "-" (str.++ "w" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "-" (str.++ "\u{5c}" (str.++ "-" (str.++ "w" (str.++ "\u{5c}" "")))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))))

(assert (= regexA (re.++ (str.to_re "")(re.++ (str.to_re (str.++ "h" (str.++ "t" (str.++ "t" (str.++ "p" (str.++ ":" (str.++ "/" (str.++ "/" (str.++ "\u{5c}" "")))))))))(re.++ (re.opt (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}")))(re.++ (str.to_re (str.++ "v" (str.++ "i" (str.++ "d" (str.++ "e" (str.++ "o" (str.++ "\u{5c}" "")))))))(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (str.to_re (str.++ "g" (str.++ "o" (str.++ "o" (str.++ "g" (str.++ "l" ""))))))(re.++ (re.+ (re.range "e" "e"))(re.++ (re.range "\u{5c}" "\u{5c}")(re.++ (re.union (re.range "\u{00}" "\u{09}") (re.range "\u{0b}" "\u{ff}"))(re.++ (re.range "\u{5c}" "\u{5c}")(re.++ ((_ re.loop 2 3) (re.range "w" "w"))(re.++ (str.to_re (str.++ "/" (str.++ "v" (str.++ "i" (str.++ "d" (str.++ "e" (str.++ "o" (str.++ "p" (str.++ "l" (str.++ "a" (str.++ "y" "")))))))))))(re.++ (re.opt (re.range "\u{5c}" "\u{5c}"))(re.++ (str.to_re (str.++ "d" (str.++ "o" (str.++ "c" (str.++ "i" (str.++ "d" (str.++ "=" ""))))))) ((_ re.loop 19 19) (re.union (re.range "-" "-")(re.union (re.range "\u{5c}" "\u{5c}") (re.range "w" "w"))))))))))))))))))))

;check that the regex contains some x
(assert (str.in_re x regexA))
;check also the concrete witnesses
(assert (str.in_re Witness1 regexA))
(assert (str.in_re Witness2 regexA))
(check-sat)
